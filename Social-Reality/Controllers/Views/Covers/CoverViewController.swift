//
//  CoverViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit
import Firebase
import FirebaseAuth

class CoverViewController: UIViewController {
    
    @IBOutlet weak var coverView: UIView!
    
    @IBOutlet weak var commentsContentView: UIView!
    @IBOutlet weak var commentsView: CreationCommentsView!
    @IBOutlet weak var bottomCommentsConstraint: NSLayoutConstraint!
    
    private var opened = false
    
    private var bottomConstraintDefault: CGFloat = 120
    private var bottomConstraintTop: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainToCoverDelegate = self

        
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
    
    func setupView() {
     
        commentsView.delegate = self
        
        bottomCommentsConstraint.constant = bottomConstraintDefault
        view.bringSubviewToFront(commentsView)
        
        
    }
    
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
    
    func checkuserData() {
        guard let id = Auth0.uid else { self.toSignIn(); return }
        Auth0.userDataExists(id: id) { res in
            if !res {
                self.toCreateUser()
            } else {
                let notificationManager = PushNotificationManager()
                notificationManager.registerForPushNotifications()
            }
        }
    }
    
    func toCreateUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreateUserFromCover.rawValue, sender: nil)
        }
    }
    
    func toSignIn() {
        self.performSegue(withIdentifier: Segue.toSignInFromCover.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateUserViewController {
            dest.email = Auth.auth().currentUser?.email
        }
    }
    
}

extension CoverViewController: CreationCommentDelegate {
    
    func dismissCommentView() {
        hideComments()
    }
    
    func presentComments() {
        bottomCommentsConstraint.constant = bottomConstraintTop
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
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
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
    
}

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
        
        
        if velocity.y > 100 {
            bottomCommentsConstraint.constant = bottomConstraintDefault
            self.resignFirstResponder()
            self.view.endEditing(true)
            commentsView.textField.resignFirstResponder()
            commentsView.endEditing(true)
        } else if velocity.y < -100 {
            bottomCommentsConstraint.constant = bottomConstraintTop
        } else if gestureView.frame.minY < view.frame.height * 0.5 {
            bottomCommentsConstraint.constant = bottomConstraintTop
        } else {
            self.resignFirstResponder()
            self.view.endEditing(true)
            commentsView.textField.resignFirstResponder()
            commentsView.endEditing(true)
            bottomCommentsConstraint.constant = bottomConstraintDefault
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
        
        gesture.setTranslation(.zero, in: view)
        
    }
    
}

extension CoverViewController: MainToCoverProtocolDelegate {
    
    func tappedComments() {
        presentComments()
    }
    
}
