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
        
        if Auth().signedIn {
            print("signed In")
        } else {
            print("Signed Out")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if !Auth().signedIn && !opened {
            toSignIn()
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
        self.performSegue(withIdentifier: "toSignInfromCover", sender: nil)
    }
    
}
