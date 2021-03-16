//
//  CreatePasswordViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterTextField: UITextField!
    
    var email: String?
    var username: String?
    var first: String?
    var last: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        reenterTextField.delegate = self
        
    }
    
    func toCreateUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreateUserFromPassword.rawValue, sender: nil)
        }
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        sender.pulsate()
        toCreateUser()
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension CreatePasswordViewController: UITextFieldDelegate {
    
    
    
}
