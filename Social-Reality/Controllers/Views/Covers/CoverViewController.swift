//
//  CoverViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit
import Firebase

class CoverViewController: UIViewController {
    
    @IBOutlet weak var coverView: UIView!
    
    private var opened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if !Auth0.loggedIn && !opened {
            toSignIn()
        } else {
            checkuserData()
        }
        
        opened = true
        openCover()
        
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
