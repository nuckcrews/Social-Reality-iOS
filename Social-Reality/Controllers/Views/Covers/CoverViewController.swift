//
//  CoverViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

class CoverViewController: UIViewController {
    
    @IBOutlet weak var coverView: UIView!
    
    private var opened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Query.datastore.start()
        
        if Auth().loggedIn {
            print("signed In")
        } else {
            print("Signed Out")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if !Auth().loggedIn && !opened {
            toSignIn()
        }
        
        if Auth().loggedIn {
            print("signed In")
        } else {
            print("Signed Out")
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
    
    func readyForRality() {
        CoverToMainDelegate?.readyForSession()
    }
    
    func toSignIn() {
        self.performSegue(withIdentifier: Segue.toSignInFromCover.rawValue, sender: nil)
    }
    
}
