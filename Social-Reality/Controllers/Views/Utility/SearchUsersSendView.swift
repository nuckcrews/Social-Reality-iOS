//
//  SearchUsersSendView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/28/21.
//

import UIKit

// MARK: - Search Users Send Utility View

class SearchUsersSendView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var selectedUsers = [UserModel]()
    var users = [UserModel]()
    var usersFiltered = [UserModel]()
    var isSearching = false
    var displaying = false
    var creation: CreationModel?
    
    private var setup = false
    
    private var defaultBottomConstraint: CGFloat = 44
    
    weak var delegate: SearchUserSendDelegate?
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setup {
            setupView()
            getUsers()
            setup = true
        }
        
    }
    
    func presented() {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - View Setup
    
    func setupView() {
        
        layer.cornerRadius = 12
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        searchBar.searchTextField.leftView?.tintColor = .primary
        
        bottomConstraint.priority = .defaultLow
        bottomConstraint.constant = defaultBottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Keyboard Observers
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = defaultBottomConstraint
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - User Fetching
    
    func getUsers() {
        Query.get.users { res in
            guard let res = res else { return }
            self.users.removeAll()
            self.users = res
            self.tableView.reloadData()
        }
    }
    
    func isSelected(model: UserModel) -> Bool {
        let res = selectedUsers.filter { mod in
            return mod.id == model.id
        }
        return res.count > 0
    }
    
    // MARK: - Creation Sending
    
    func sendCreation() {
        
        guard let uid = Auth0.uid, selectedUsers.count > 0 else { return }
        
        var ids = [String]()
        
        var message = MessageModel(id: UUID().uuidString, conversationID: uid, senderID: uid, recipientID: "", content: "", date: Date().rawDateString, type: .creation, creationID: creation?.id, creationImage: creation?.thumbnail, creationUserName: creation?.userName, creationUserImage: creation?.userImage, creationCaption: creation?.description)
        
        var followMessage: MessageModel?
        
        if textField.text?.count ?? 0 > 0 {
            followMessage = MessageModel(id: UUID().uuidString, conversationID: uid, senderID: uid, recipientID: "", content: textField.text ?? "", date: Date(timeIntervalSinceNow: 1).rawDateString, type: .message)
        }
        
        for user in selectedUsers {
            let id = [uid, user.id]
            let joined = id.sorted().joined()
            ids.append(joined)
            message.conversationID = joined
            message.recipientID = user.id
            if followMessage != nil {
                followMessage?.conversationID = joined
                followMessage?.recipientID = user.id
            }
            
            checkForConversation(ids: id, message: message, followMessage: followMessage)
        }
        
    }
    
    // MARK: - Existing Conversation Check
    
    func checkForConversation(ids: [String], message: MessageModel, followMessage: MessageModel? = nil) {
        
        Query.get.conversation(id: message.conversationID) { [weak self] model in
            if model != nil {
                self?.writeMessage(message, follow: followMessage)
            } else {
                let conversation = ConversationModel(id: message.conversationID,
                                                     userIDs: ids,
                                                     lastMessage: message.content,
                                                     lastMessageDate: Date().rawDateString,
                                                     image: "")
                Query.write.conversation(conversation) { [weak self] res in
                    self?.writeMessage(message, follow: followMessage)
                }
            }
        }
    
    }
    
    // MARK: - Write Message
    
    func writeMessage(_ message: MessageModel, follow: MessageModel?) {
        Query.write.message(message) { [weak self] result in
            print(result)
            if let followMessage = follow {
                Query.write.message(followMessage) { [weak self] res in
                    self?.textField.text = ""
                    self?.sendButton.backgroundColor = .grayText
                    self?.delegate?.dismissSearchUserSendView()
                }
            } else {
                self?.textField.text = ""
                self?.sendButton.backgroundColor = .grayText
                self?.delegate?.dismissSearchUserSendView()
            }
        }

    }

    // MARK: - Action Outlets
    
    @IBAction func tapSend(_ sender: UIButton) {
        guard let _ = textField.text else {
            return
        }
        sender.pulsate()
        Buzz.light()
        
        sendCreation()
        
    }
    
}

// MARK: - Search Bar Delegate

extension SearchUsersSendView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchText.count > 0
        
        let res = users.filter { user in
            return user.username.lowercased().contains(searchText.lowercased()) ||
                user.first.lowercased().contains(searchText.lowercased()) ||
                user.last.lowercased().contains(searchText.lowercased())
        }
        
        usersFiltered = res
        
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
        delegate?.dismissSearchUserSendView()
    }
    
}

// MARK: - ScrollView Delegate

extension SearchUsersSendView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - TextField Delegate

extension SearchUsersSendView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
}

// MARK: - TableView Delegate

extension SearchUsersSendView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            if usersFiltered.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return usersFiltered.count
        } else {
            if users.count > 0 {
                tableView.alpha = 1
            } else {
                tableView.alpha = 0
            }
            return users.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchUserCell.rawValue, for: indexPath) as? searchUserCell {
            isSearching ?
                cell.configureCell(user: usersFiltered[indexPath.row], selectedCell: isSelected(model: usersFiltered[indexPath.row])) :
                cell.configureCell(user: users[indexPath.row], selectedCell: isSelected(model: users[indexPath.row]))
            return cell
        } else {
            return searchUserCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? searchUserCell else {
            return
        }
        
        if isSearching {
            if isSelected(model: usersFiltered[indexPath.row]) {
                selectedUsers = selectedUsers.filter({ model in
                    return model.id != usersFiltered[indexPath.row].id
                })
            } else {
                selectedUsers.append(usersFiltered[indexPath.row])
            }
        } else {
            if isSelected(model: users[indexPath.row]) {
                selectedUsers = selectedUsers.filter({ model in
                    return model.id != users[indexPath.row].id
                })
            } else {
                selectedUsers.append(users[indexPath.row])
            }
        }
        
        delegate?.selectUsers(models: selectedUsers)
        
        cell.tapSelect()
        
    }
    
}
