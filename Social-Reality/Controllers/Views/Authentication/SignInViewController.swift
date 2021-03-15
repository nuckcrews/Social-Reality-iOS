//
//  SignInViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit
import Amplify
import AmplifyPlugins
import GoogleSignIn
import FBSDKLoginKit
import AWSGoogleSignIn
import AWSUserPoolsSignIn
import GTMAppAuth
import AppAuth
import AuthenticationServices

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIndicatorButton: UIButton!
    
//    var loginButton: FBLoginButton!
//    var googleBtn: GIDSignInButton?
    var email: String?
    var social = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
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
    
    
    @IBAction func tapEmailContinue(_ sender: UIButton) { // FIXME: Sing in through Email
        
        if emailTextField.text!.isValidEmail() {
            Auth().userExists(email: emailTextField.text!) { (res) in
                if res != nil {
                    self.email = self.emailTextField.text
                    !res! ? self.toEmailPassword() : self.toCreatePassword()
                }
            }
            sender.pulsate()
        } else {
            sender.shake()
        }
        
    }
    
    func checkForUserInformation(provider: String) { // FIXME: Have to check for provider
        if !Auth().loggedIn {
            self.presentAlert(title: "Error Signing In", message: "There could have been a mistake on our end. Please try signing in again.", button: "Ok")
        } else {
            Auth().userAttributes { (attributes) in
                if let attributeEmail = attributes?["email"] {
                    self.email = attributeEmail
                    Auth().userExists(email: attributeEmail) { (res) in
                        if res != nil {
                            !res! ? self.toNewUser() : self.toHome()
                        } else {
                            print("No result")
                            self.presentAlert(title: "Error Signing In", message: "There could have been a mistake on our end. Please try signing in again.", button: "Ok")
                        }
                    }
                } else {
                    print("No email")
                    self.presentAlert(title: "Error Signing In", message: "There could have been a mistake on our end. Please try signing in again.", button: "Ok")
                }
            }
        }
    }
    
    @IBAction func tapGoogleSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .google, window: window) { res in
            if res == .success {
                self.checkForUserInformation(provider: "Google")
            } else {
                print("Error signing In")
                
            }
        }
    }
    
    @IBAction func tapFacebookSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .facebook, window: window) { res in
            if res == .success {
                self.checkForUserInformation(provider: "Facebook")
            } else {
                print("Error signing In")
                
            }
        }
    }
    
    @IBAction func tapAppleSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .apple, window: window) { res in
            if res == .success {
                self.checkForUserInformation(provider: "Apple")
            } else {
                print("Error signing In")
                
            }
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func toCreatePassword() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreatePasswordfromSignIn.rawValue, sender: nil)
        }
    }
    func toEmailPassword() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toPasswordfromSign.rawValue, sender: nil)
        }
    }
    func toNewUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toNewUserfromSign.rawValue, sender: nil)
        }
    }
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toHomefromSignIn.rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateUserViewController {
            dest.email = email
        }
        if let dest = segue.destination as? CreatePasswordViewController {
            dest.email = emailTextField.text
        }
        if let dest = segue.destination as? PasswordViewController {
            dest.email = emailTextField.text
        }
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text!.trimmingCharacters(in: .whitespaces)
        
        if textField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.emailIndicatorButton.alpha = 0
            }
        } else {
            if textField.text!.isValidEmail() {
                self.emailIndicatorButton.tintColor = .green
            } else {
                self.emailIndicatorButton.tintColor = .systemGray4
            }
            UIView.animate(withDuration: 0.3) {
                self.emailIndicatorButton.alpha = 1
            }
            
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.emailIndicatorButton.alpha = 1
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.emailIndicatorButton.alpha = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.text!.isValidEmail() {
            Auth().userExists(email: emailTextField.text!) { (res) in
                if res != nil {
                    res! ? self.toEmailPassword() : self.toNewUser()
                }
            }
            return true
        } else {
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
