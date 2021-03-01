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
    
    @IBAction func tapContinue(_ sender: UIButton) {
        sender.pulsate()
        self.performSegue(withIdentifier: "toHomefromCreatePassword", sender: nil)
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension CreatePasswordViewController: UITextFieldDelegate {
    
    
    
}
