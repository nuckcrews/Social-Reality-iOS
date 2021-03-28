//
//  CreationCommentsViews.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import UIKit

class CreationCommentsView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var defaultBottomConstraint: CGFloat = 44
    private var setup = false
    var creation: CreationModel?
    var comments = [CommentModel]()
    weak var user: User?
    
    weak var delegate: CreationCommentDelegate?
    
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
    
    func getComments() {
        
        guard let creation = creation else {
            defaultComments()
            return
        }
        
        Query.get.commentsWithPredicate(field: "creationID", value: creation.id) { models in
            guard let models = models else { return }
            
            self.comments = models
            
            self.comments.sort { $0.date?.rawDate ?? Date() < $1.date?.rawDate ?? Date() }
            
            self.tableView.reloadData()
            self.stopLoading()
        }
        
    }
    
    func setupView() {
        
        layer.cornerRadius = 12
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        bottomConstraint.priority = .defaultLow
        bottomConstraint.constant = defaultBottomConstraint
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        activityIndicator.layer.cornerRadius = 12
        activityIndicator.alpha = 0
        activityIndicator.style = .medium
        
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
    
    func presented() {
        
        getComments()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboard hiding", bottomConstraint.constant)
        bottomConstraint.constant = defaultBottomConstraint
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    func postComment() {
        guard let creation = creation, let uid = Auth0.uid else {
            return
        }
        
        let UUID = UUID().uuidString
        let comment = CommentModel(id: UUID,
                                   content: textField.text ?? "",
                                   status: "ACTIVE",
                                   creationID: creation.id,
                                   userID: uid,
                                   userImage: user?.model?.image,
                                   userName: user?.model?.username,
                                   date: Date().rawDateString)
        
        Query.write.comment(comment) { res in
            if res == .success {
                self.getComments()
                self.textField.text = ""
                self.textField.resignFirstResponder()
                self.endEditing(true)
            } else {
                print("error")
            }
        }
        
        
    }
    
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

extension CreationCommentsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    
    
}

extension CreationCommentsView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
        textField.resignFirstResponder()
    }
    
}

extension CreationCommentsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.commentCell.rawValue, for: indexPath) as? commentCell {
            cell.configureCell(comment: comments[indexPath.row], liked: nil)
            return cell
        } else {
            return commentCell()
        }
    }
    
}
