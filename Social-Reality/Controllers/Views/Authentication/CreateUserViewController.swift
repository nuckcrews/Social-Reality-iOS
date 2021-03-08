//
//  CreateUserViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit
import Amplify
import AmplifyPlugins

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var usernameTextIndicator: UIButton!
    @IBOutlet weak var firstTextIndicator: UIButton!
    @IBOutlet weak var lastTextIndicator: UIButton!
    
    @IBOutlet weak var usernameTakenLabel: UILabel!
    
    var email: String?
    var social = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTakenLabel.alpha = 0
        
        usernameTextField.delegate = self
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        firstnameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        lastnameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func checkUserName() {
        guard let username = usernameTextField.text else {
            return
        }
        Auth().usernameExists(username: username) { (exists) in
            DispatchQueue.main.async {
                if exists {
                    print("username exists")
                    
                    self.usernameTakenLabel.alpha = 1
                    self.usernameTextIndicator.tintColor = .red
                } else {
                    self.usernameTextIndicator.tintColor = .green
                    self.social ? self.createUser() : self.toPassword()
                }
            }
        }
        
    }
    
    func createUser() {
        
        let user = UserModel(id: Auth().user!.userId, username: usernameTextField.text!, status: nil, first: firstnameTextField.text, last: lastnameTextField.text, lastActive: nil, access: .public, email: email!)
        Query.write.user(user) { (result) in
            if result != nil {
                print("Created user")
                self.toHome()
            } else {
                print("Error Creating User")
            }
        }
        
        
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        if usernameTextField.text != "" {
            sender.pulsate()
            checkUserName()
        } else {
            sender.shake()
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func toPassword() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toPasswordfromCreateUser", sender: nil)
        }
    }
    
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toHomefromCreateUser", sender: nil)
        }
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == usernameTextField {
            usernameTakenLabel.alpha = 0
            usernameTextIndicator.tintColor = .systemGray4
        } else if textField == firstnameTextField {
            if textField.text?.count ?? 0 > 0 {
                firstTextIndicator.tintColor = .green
            } else {
                firstTextIndicator.tintColor = .systemGray4
            }
        } else {
            if textField.text?.count ?? 0 > 0 {
                lastTextIndicator.tintColor = .green
            } else {
                lastTextIndicator.tintColor = .systemGray4
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if usernameTextField.text != "" {
//            checkUserName()
            
            return true
        } else {
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
