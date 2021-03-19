//
//  PasswordViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordIndicator: UIButton!
    
    var email: String?
    
    struct AlertError {
        static var title = "Error Signing In"
        static var message = "There could have been a mistake on our end. Please try signing in again."
        static var button = "Ok"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func presentAlert(title: String, message: String, button: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: button, style: .default, handler: { action in
                                            switch action.style{
                                            case .default:
                                                print("default")
                                            case .cancel:
                                                print("cancel")
                                            case .destructive:
                                                print("destructive")
                                            @unknown default:
                                                print("Error")
                                            }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func signInUser() {
        guard let email = email, let password = passwordTextField.text else { return }
        
        
    }
    
    func confirmUser(text: String) {

        
    }
    
    
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toHomeFromPassword.rawValue, sender: nil)
        }
    }
    
    func toCreateUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreateUserFromPasswordEnter.rawValue, sender: nil)
        }
    }
    
    func toConfirmUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toConfirmUserFromPassword.rawValue, sender: nil)
        }
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        if passwordTextField.text != "" {
            sender.pulsate()
            signInUser()
        } else {
            sender.shake()
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateUserViewController {
            dest.email = email
        }
        if let dest = segue.destination as? ConfirmUserViewController {
            dest.email = email
            dest.password = passwordTextField.text
        }
    }
    
}

extension PasswordViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if passwordTextField.text != nil && passwordTextField.text!.isValidPassword() {
            passwordIndicator.tintColor = .systemGreen
        } else {
            passwordIndicator.tintColor = .grayText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if passwordTextField.text != "" {
            signInUser()
        }
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
