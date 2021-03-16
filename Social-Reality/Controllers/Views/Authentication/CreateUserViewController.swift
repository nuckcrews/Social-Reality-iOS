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
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var usernameTextIndicator: UIButton!
    @IBOutlet weak var firstTextIndicator: UIButton!
    @IBOutlet weak var lastTextIndicator: UIButton!
    
    @IBOutlet weak var usernameTakenLabel: UILabel!
    
    var email: String?
    var provider: AuthenticationProvider = .email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTakenLabel.alpha = 0
        
        usernameTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func getProvider() {
        
        Auth().fetchAuthProvider { result in
            if let result = result {
                if result == .Google {
                    self.provider = .google
                } else if result == .Facebook {
                    self.provider = .facebook
                } else if result == .Apple {
                    self.provider = .apple
                } else if result == .Email {
                    self.provider = .email
                }
            }
        }
        
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
                    self.createUser()
                }
            }
        }
        
    }
    
    func createUser() {
        guard let id = Auth().user?.userId else {
            return
        }
        let user = UserModel(id: id, username: usernameTextField.text!, status: "", first: firstNameTextField.text, last: lastNameTextField.text, lastActive: "", access: .public, email: email!, image: "", provider: provider)
        Query.datastore.write.user(user) { (result) in
            if result != nil {
                print("Created user")
                self.toAvatar()
            } else {
                print("Error Creating User")
            }
        }
        
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        if usernameTextField.text != "" && firstNameTextField.text != "" {
            sender.pulsate()
            checkUserName()
        } else {
            sender.shake()
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func toAvatar() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toAvatarFromCreateUser.rawValue, sender: nil)
        }
    }
    
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toHomeFromCreateUser.rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreatePasswordViewController {
            dest.email = email
            dest.username = usernameTextField.text
            dest.first = firstNameTextField.text
            dest.last = lastNameTextField.text
        }
    }
    
}

extension CreateUserViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == usernameTextField {
            textField.text = textField.text?.lowercased()
            textField.text = textField.text?.replacingOccurrences(of: " ", with: "_")
            usernameTakenLabel.alpha = 0
            usernameTextIndicator.tintColor = .systemGray4
        } else if textField == firstNameTextField {
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
            return true
        } else {
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
