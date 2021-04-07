//
//  MessageViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/6/21.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomTextConstraint: NSLayoutConstraint!
    
    var conversation: ConversationModel?
    var recipient: UserModel?
    var recipientID: String?
    var messages = [MessageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getRecipient()
        getMessages()
        
    }
    
    func setupView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bottomTextConstraint.constant = 0
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomTextConstraint.constant = keyboardSize.height - 26
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
    
    func getRecipient() {
        
        guard let recipientID = recipientID else { return }
        
        Query.get.user(id: recipientID) { [weak self] model in
            guard let model = model else { return }
            self?.recipient = model
            self?.userImageView.setImageFromURL(model.image)
            self?.userNameLabel.text = model.username
        }
        
    }
    
    func getMessages() {
        
        guard let conversation = conversation else { return }
        
        Query.subscribe.messages(conversationID: conversation.id) { [weak self] models, lst in
            guard let models = models else { return }
            self?.messages = models
            self?.sortMessages()
        }
        
    }
    
    func sortMessages() {
        
        messages.sort(by: { $0.date.rawDate ?? Date() > $1.date.rawDate ?? Date() } )
        
        tableView.reloadData()
        
    }
    
    @IBAction func tapSend(_ sender: UIButton) {
        Buzz.light()
        sender.pulsate()
        
        guard let text = textField.text, text.count > 0 else { return }
        
        // POST MESSAGE
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MessageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textField.resignFirstResponder()
        view.endEditing(true)
    }
    
}

extension MessageViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if text.count > 0 {
            sendButton.backgroundColor = .grayText
        } else {
            sendButton.backgroundColor = .primary
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.messageCell.rawValue, for: indexPath) as? messageCell {
            cell.configureCell(message: messages[indexPath.row])
            return cell
        } else {
            return messageCell()
        }
    }
}
