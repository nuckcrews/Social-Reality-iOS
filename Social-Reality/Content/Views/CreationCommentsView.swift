//
//  CreationCommentsViews.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import UIKit

// MARK: - Creation Comments Utility View

class CreationCommentsView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    private var defaultBottomConstraint: CGFloat = 44
    private var setup = false
    var creation: CreationModel?
    var comments = [CommentModel]()
    var user: UserModel?
    
    weak var delegate: CreationCommentDelegate?
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setup {
            setupView()
            setup = true
        }
        
    }
    
    func defaultComments() {
        let comment = CommentModel(id: "dfferfa",
                                   content: "So cool! Love how you blended it with the real wolrd.",
                                   status: "ACTIVE",
                                   creationID: "",
                                   userID: "",
                                   userImage: "",
                                   userName: "testuser")
        
        comments.removeAll()
        for _ in 0...24 {
            comments.append(comment)
        }
        
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    func presented() {
        
        getComments()
        
    }
    
    // MARK: - View Setup
    
    func setupView() {
        
        layer.cornerRadius = 12
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 48, right: 0)
        
        bottomConstraint.priority = .defaultLow
        bottomConstraint.constant = defaultBottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        activityIndicator.layer.cornerRadius = 12
        activityIndicator.alpha = 0
        activityIndicator.style = .medium
        
    }
    
    // MARK: - Comment Fetching
    
    func getComments() {
        
        guard let creation = creation else {
            defaultComments()
            return
        }
        
        Query.remote.get.commentsWithPredicate(field: "creationID", value: creation.id) { models in
            guard let models = models else { return }
            
            self.comments = models
            
            self.comments.sort { $0.date?.rawDate ?? Date() < $1.date?.rawDate ?? Date() }
            
            self.tableView.reloadData()
            self.stopLoading()
        }
        
    }
    
    func startLoading() {
        tableView.alpha = 0
        bringSubviewToFront(activityIndicator)
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        tableView.alpha = 1
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        
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
    
    // MARK: - Comment Posting
    
    func postComment() {
        guard let creation = creation,
              let uid = Auth0.uid else {
            return
        }
        
        let UUID = UUID().uuidString
        let comment = CommentModel(id: UUID,
                                   content: textField.text ?? "",
                                   status: "ACTIVE",
                                   creationID: creation.id,
                                   userID: uid,
                                   userImage: user?.image,
                                   userName: user?.username,
                                   date: Date().rawDateString)
        
        Query.remote.write.comment(comment) { res in
            if res == .success {
                self.getComments()
                self.textField.text = ""
                self.textField.resignFirstResponder()
                self.endEditing(true)
                self.tableView.scrollToBottom()
            } else {
                print("error")
            }
        }
        
        
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapPost(_ sender: UIButton) {
        guard let text = textField.text, text.count > 0 else {
            return
        }
        sender.pulsate()
        Buzz.light()
        
        postComment()
        
    }
    
    @IBAction func tapDone(_ sender: UIButton) {
        self.endEditing(true)
        textField.resignFirstResponder()
        delegate?.dismissCommentView()
    }
    
}

// MARK: - TextField Delegate

extension CreationCommentsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
}

// MARK: - ScrollView Delegate

extension CreationCommentsView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        textField.resignFirstResponder()
    }
    
}

// MARK: - TableView Delegate

extension CreationCommentsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifiers.commentCell.rawValue, for: indexPath) as? CommentCell {
            cell.configureCell(comment: comments[indexPath.row], liked: nil)
            return cell
        } else {
            return CommentCell()
        }
    }
    
}
