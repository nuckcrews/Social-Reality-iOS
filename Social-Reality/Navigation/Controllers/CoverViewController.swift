//
//  CoverViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit
import Firebase
import FirebaseAuth

// MARK: - Cover View Controller

class CoverViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var coverView: UIView!
    
    @IBOutlet weak var commentsContentView: UIView!
    @IBOutlet weak var commentsView: CreationCommentsView!
    @IBOutlet weak var bottomCommentsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchUsersContentView: UIView!
    @IBOutlet weak var searchUsersView: SearchUsersSendView!
    @IBOutlet weak var bottomSearchUsersConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var blackView = UIView()
    
    private var opened = false
    
    private var bottomConstraintDefault: CGFloat = 120
    private var bottomConstraintTop: CGFloat = 0
    
    var user: UserModel?
    
    var messageData: (String, String?) = ("", nil)
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> CoverViewController? {

        guard let viewController = Storyboard.Main.instantiate(CoverViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainToCoverDelegate = self
        
        setupLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        bottomConstraintTop = -view.frame.height * 0.8
        
        if !Auth0.loggedIn && !opened {
            toSignIn()
        } else if !opened {
            checkuserData()
        } else {
            let notificationManager = PushNotificationManager()
            notificationManager.registerForPushNotifications()
        }
        
        opened = true
        openCover()
        
        setupView()
        
    }
    
    // MARK: - View Setup
    
    func setupLoad() {
        
        bottomSearchUsersConstraint.constant = bottomConstraintDefault
        bottomCommentsConstraint.constant = bottomConstraintDefault
        
        blackView.alpha = 0
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.frame = view.bounds
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissViews)))
        
        view.addSubview(blackView)
        
    }
    
    func setupView() {
        
        commentsView.delegate = self
        searchUsersView.delegate = self
        
        bottomSearchUsersConstraint.constant = bottomConstraintDefault
        bottomCommentsConstraint.constant = bottomConstraintDefault
        
        view.bringSubviewToFront(searchUsersContentView)
        view.bringSubviewToFront(commentsContentView)
        
        
    }
    
    // MARK: - User Fetching
    
    func getUser() {
        guard let uid = Auth0.uid else { return }
        
        if let user = Query.defaults.get.user(uid) {
            commentsView.user = user
        }
        Query.subscribe.user(uid) { [weak self] model, lstn in
            guard let model = model else { return }
            if self?.user != model {
                Query.defaults.write.user(model)
                self?.user = model
                self?.commentsView.user = model
            }
        }
        
    }
    
    func checkuserData() {
        guard let id = Auth0.uid else { self.toSignIn(); return }
        Auth0.userDataExists(id: id) { [weak self] res in
            if !res {
                self?.toCreateUser()
            } else {
                let notificationManager = PushNotificationManager()
                notificationManager.registerForPushNotifications()
                self?.getUser()
            }
        }
    }
    
    // MARK: - Utility View Presenters
    
    @objc func dismissViews() {
        hideComments()
        hideSearchUsers()
    }
    
    // MARK: - Cover Opening
    
    func openCover() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
            UIView.animate(withDuration: 0.4) {
                self.coverView.alpha = 0
            }
        }
    }
    
    func readyForReality() {
        CoverToMainDelegate?.readyForSession()
    }
    
    // MARK: - Segues
    
    func toCreateUser() {
        
        DispatchQueue.main.async {
            
            if let viewController = CreateUserViewController.instantiate(email: Auth.auth().currentUser?.email) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toSignIn() {

        DispatchQueue.main.async {
            
            if let viewController = SignInViewController.instantiate() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
}

// MARK: - Creation Comment Delegate

extension CoverViewController: CreationCommentDelegate {
    
    func dismissCommentView() {
        hideComments()
    }
    
    func presentComments() {
        bottomCommentsConstraint.constant = bottomConstraintTop
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.blackView.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.commentsView.presented()
        }
    }
    
    func hideComments() {
        bottomCommentsConstraint.constant = bottomConstraintDefault
        self.resignFirstResponder()
        self.view.endEditing(true)
        commentsView.textField.resignFirstResponder()
        commentsView.endEditing(true)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.blackView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
}

// MARK: - Search User Send Delegate

extension CoverViewController: SearchUserSendDelegate {
    
    func selectUsers(models: [UserModel]) {
        
    }
    
    func dismissSearchUserSendView() {
        hideSearchUsers()
    }
    
    func presentSearchUser() {
        bottomSearchUsersConstraint.constant = bottomConstraintTop
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.blackView.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.searchUsersView.presented()
        }
    }
    
    func hideSearchUsers() {
        bottomSearchUsersConstraint.constant = bottomConstraintDefault
        self.resignFirstResponder()
        self.view.endEditing(true)
        searchUsersView.resignFirstResponder()
        searchUsersView.endEditing(true)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.blackView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
}

// MARK: - Pan Gesture Action Outlets

extension CoverViewController {
    
    @IBAction func bottomCommentPanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else { return }
        
        
        if translation.y < 0 {
            if gestureView.frame.minY + translation.y >= view.frame.height * 0.2 {
                bottomCommentsConstraint.constant = bottomCommentsConstraint.constant + translation.y
            } else {
                bottomCommentsConstraint.constant = bottomConstraintTop
            }
        } else if translation.y > 0 {
            if bottomCommentsConstraint.constant + translation.y <= bottomConstraintDefault {
                self.resignFirstResponder()
                self.view.endEditing(true)
                commentsView.textField.resignFirstResponder()
                commentsView.endEditing(true)
                bottomCommentsConstraint.constant = bottomCommentsConstraint.constant + translation.y
            } else {
                bottomCommentsConstraint.constant = bottomConstraintDefault
            }
        }
        
        guard gesture.state == .ended else {
            gesture.setTranslation(.zero, in: view)
            return
        }
        
        let velocity = gesture.velocity(in: view)
        
        var blackAlpha: CGFloat = 0
        
        if velocity.y > 100 {
            bottomCommentsConstraint.constant = bottomConstraintDefault
            self.resignFirstResponder()
            self.view.endEditing(true)
            commentsView.textField.resignFirstResponder()
            commentsView.endEditing(true)
            blackAlpha = 0
        } else if velocity.y < -100 {
            bottomCommentsConstraint.constant = bottomConstraintTop
            blackAlpha = 1
        } else if gestureView.frame.minY < view.frame.height * 0.5 {
            bottomCommentsConstraint.constant = bottomConstraintTop
            blackAlpha = 1
        } else {
            self.resignFirstResponder()
            self.view.endEditing(true)
            commentsView.textField.resignFirstResponder()
            commentsView.endEditing(true)
            blackAlpha = 0
            bottomCommentsConstraint.constant = bottomConstraintDefault
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = blackAlpha
            self.view.layoutIfNeeded()
        })
        
        gesture.setTranslation(.zero, in: view)
        
    }
    
    @IBAction func bottomSearchUserPanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        guard let gestureView = gesture.view else { return }
        
        
        if translation.y < 0 {
            if gestureView.frame.minY + translation.y >= view.frame.height * 0.2 {
                bottomSearchUsersConstraint.constant = bottomSearchUsersConstraint.constant + translation.y
            } else {
                bottomSearchUsersConstraint.constant = bottomConstraintTop
            }
        } else if translation.y > 0 {
            if bottomSearchUsersConstraint.constant + translation.y <= bottomConstraintDefault {
                self.resignFirstResponder()
                self.view.endEditing(true)
                searchUsersView.resignFirstResponder()
                searchUsersView.endEditing(true)
                bottomSearchUsersConstraint.constant = bottomSearchUsersConstraint.constant + translation.y
            } else {
                bottomSearchUsersConstraint.constant = bottomConstraintDefault
            }
        }
        
        guard gesture.state == .ended else {
            gesture.setTranslation(.zero, in: view)
            return
        }
        
        let velocity = gesture.velocity(in: view)
        
        var blackAlpha: CGFloat = 0
        
        if velocity.y > 100 {
            bottomSearchUsersConstraint.constant = bottomConstraintDefault
            self.resignFirstResponder()
            self.view.endEditing(true)
            searchUsersView.resignFirstResponder()
            searchUsersView.endEditing(true)
            blackAlpha = 0
        } else if velocity.y < -100 {
            bottomSearchUsersConstraint.constant = bottomConstraintTop
            blackAlpha = 1
        } else if gestureView.frame.minY < view.frame.height * 0.5 {
            bottomSearchUsersConstraint.constant = bottomConstraintTop
            blackAlpha = 1
        } else {
            self.resignFirstResponder()
            self.view.endEditing(true)
            searchUsersView.resignFirstResponder()
            searchUsersView.endEditing(true)
            bottomSearchUsersConstraint.constant = bottomConstraintDefault
            blackAlpha = 0
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.blackView.alpha = blackAlpha
            self.view.layoutIfNeeded()
        })
        
        gesture.setTranslation(.zero, in: view)
        
    }
    
}

// MARK: - Main to Cover Delegate

extension CoverViewController: MainToCoverProtocolDelegate {
    
    func tappedComments(creation: CreationModel?) {
        commentsView.creation = creation
        commentsView.startLoading()
        presentComments()
    }
    
    func tappedSendCreation(creation: CreationModel?) {
        searchUsersView.creation = creation
        presentSearchUser()
    }
    
    func segueToMessage(recipientID: String, conversationID: String?) {
        
        messageData = (recipientID, conversationID)

        DispatchQueue.main.async {
            
            if let viewController = MessageViewController.instantiate(conversationID: conversationID, recipientID: recipientID) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
}
