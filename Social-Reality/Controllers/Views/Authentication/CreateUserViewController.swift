//
//  CreateUserViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var usernameTextIndicator: UIButton!
    @IBOutlet weak var firstTextIndicator: UIButton!
    @IBOutlet weak var lastTextIndicator: UIButton!
    
    @IBOutlet weak var usernameTakenLabel: UILabel!
    
    var email: String?
    
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
    
    func checkUserName() {
        guard let username = usernameTextField.text else {
            return
        }
        
    }
    
    func createUser() {
        guard let id = Auth0.uid else { 
            return
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
