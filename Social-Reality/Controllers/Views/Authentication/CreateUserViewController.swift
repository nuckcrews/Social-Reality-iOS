//
//  CreateUserViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        if usernameTextField.text != "" {
            sender.pulsate()
            
            self.performSegue(withIdentifier: "toPasswordfromCreateUser", sender: nil)
            
        } else {
            sender.pulsate()
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreatePasswordViewController {
            dest.email = email
            dest.username = usernameTextField.text
            dest.first = firstnameTextField.text
            dest.last = lastnameTextField.text
        }
    }
    
}

extension CreateUserViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if usernameTextField.text != "" {
            
            self.performSegue(withIdentifier: "toPasswordfromCreateUser", sender: nil)
            return true
        } else {
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
