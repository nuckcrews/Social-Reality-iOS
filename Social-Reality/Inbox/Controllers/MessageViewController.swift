//
//  MessageViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import UIKit

// MARK: - Message View Controller

class MessageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomTextConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var conversation: ConversationModel?
    var conversationID: String?
    var recipient: UserModel?
    var recipientID: String?
    var messages = [MessageModel]()
    var selectedMessage: MessageModel?
    var creations = [CreationModel]()
    var selectedIndex = 0
    
    // MARK: - View Instantiation
    
    internal static func instantiate(conversationID: String?, recipientID: String) -> MessageViewController? {

        guard let viewController = Storyboard.Main.instantiate(MessageViewController.self) else {
            return nil
        }
        
        viewController.conversationID = conversationID
        viewController.recipientID = recipientID
        
        return viewController
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        guard let uid = Auth0.uid,
              let recipientID = recipientID else { return }
        
        if conversationID == nil {
            var ids = [uid, recipientID]
            
            ids.sort()
            let id = ids.joined()
            print(id)
            
            conversationID = id
        }
        
        checkForConversation()
        getRecipient()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        textField.becomeFirstResponder()
        
        tableView.scrollToBottom()
        
    }
    
    // MARK: - View Setup
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bottomTextConstraint.constant = 0
        
    }
    
    // MARK: - Keyboard Observers
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomTextConstraint.constant = keyboardSize.height - Device.bottomSafeAreaHeight
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomTextConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Recipient Fetching
    
    func getRecipient() {
        
        guard let recipientID = recipientID else {
            recipient = Testing.defaultUser.model
            userImageView.setImageFromURL(recipient?.image ?? "")
            userNameLabel.text = recipient?.username
            return
        }
        
        
        Query.get.user(recipientID) { [weak self] model in
            guard let model = model else {
                self?.recipient = Testing.defaultUser.model
                self?.userImageView.setImageFromURL(self?.recipient?.image ?? "")
                self?.userNameLabel.text = self?.recipient?.username
                return
            }
            self?.recipient = model
            self?.userImageView.setImageFromURL(model.image)
            self?.userNameLabel.text = model.username
        }
        
    }
    
    // MARK: - Message Fetching
    
    func getMessages() {
        
        guard let conversation = conversation else { return }
        
        Query.remote.subscribe.messages(conversationID: conversation.id) { [weak self] models, lst in
            guard let models = models else { return }
            self?.messages = models
            self?.sortMessages()
        }
        
    }
    
    func getCreations() {
        for message in messages {
            if message.type == .creation {
                guard let id = message.creationID else { continue }
                creations.removeAll()
                Query.remote.get.creation(id) { [weak self] model in
                    if let model = model {
                        self?.creations.append(model)
                    }
                }
            }
        }
    }
    
    func sortMessages() {
        
        messages.sort(by: { $0.date.rawDate ?? Date() < $1.date.rawDate ?? Date() } )
        
        tableView.reloadData()
        
        tableView.scrollToBottom()
        
        getCreations()
        
        
    }
    
    // MARK: - Post Message
    
    func postMessage() {
        
        guard let conversationID = conversationID,
              let uid = Auth0.uid,
              let recipientID = recipientID,
              let text = textField.text
        else { return }
        
        let message = MessageModel(id: UUID().uuidString,
                                   conversationID: conversationID,
                                   senderID: uid,
                                   recipientID: recipientID,
                                   content: text,
                                   date: Date().rawDateString,
                                   type: .message)
        
        if conversation == nil {
            let conversation = ConversationModel(id: conversationID,
                                                 userIDs: [uid, recipientID],
                                                 lastMessage: text,
                                                 lastMessageDate: Date().rawDateString,
                                                 image: "")
            
            Query.write.conversation(conversation) { [weak self] res in
                Query.write.message(message) { [weak self] result in
                    print(result)
                    self?.textField.text = ""
                    self?.sendButton.backgroundColor = .grayText
                }
            }
        } else {
            Query.write.message(message) { [weak self] result in
                print(result)
                self?.textField.text = ""
                self?.sendButton.backgroundColor = .grayText
            }
        }
        
        
        
    }
    
    func checkForConversation() {
        guard let conversationID = conversationID else { return }
        
        Query.get.conversation(conversationID) { [weak self] model in
            self?.conversation = model
            self?.getMessages()
        }
        
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapSend(_ sender: UIButton) {
        Buzz.light()
        sender.pulsate()
        
        guard let text = textField.text, text.count > 0 else { return }
        
        postMessage()
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Segues
    
    func toCreationTableView() {

        DispatchQueue.main.async {
            
            if let viewController = CreationTableViewController.instantiate(creations: self.creations, selectedIndex: self.selectedIndex) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
}

// MARK: - ScrollView Delegate

extension MessageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}

// MARK: - TextField Delegate

extension MessageViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if text.count > 0 {
            sendButton.backgroundColor = .primary
        } else {
            sendButton.backgroundColor = .grayText
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Buzz.light()
        
        guard let text = textField.text, text.count > 0 else { return false }
        
        postMessage()
        
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

// MARK: - TableView Delegate

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch messages[indexPath.row].type {
        case .creation:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MessageCreationCell.identifiers.messageCreationCell.rawValue, for: indexPath) as? MessageCreationCell {
                cell.configureCell(message: messages[indexPath.row], del: self)
                return cell
            } else {
                return MessageCreationCell()
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifiers.messageCell.rawValue, for: indexPath) as? MessageCell {
                cell.configureCell(message: messages[indexPath.row])
                return cell
            } else {
                return MessageCell()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if messages[indexPath.row].type == .creation {
            
        }
        
    }
    
}

extension MessageViewController: MessageCellDelegate {
    func selectedCreation(id: String) {
        for i in 0..<creations.count {
            if id == creations[i].id {
                selectedIndex = i
            }
        }
        toCreationTableView()
    }
}

protocol MessageCellDelegate: AnyObject {
    func selectedCreation(id: String)
}
