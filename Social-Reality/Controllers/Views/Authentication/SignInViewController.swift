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
    
    var email: String?
    var provider: AuthenticationProvider = .email
    
    struct AlertError {
        static var title = "Error Signing In"
        static var message = "There could have been a mistake on our end. Please try signing in again."
        static var button = "Ok"
    }
    
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
    
    
    @IBAction func tapEmailContinue(_ sender: UIButton) {
        
        guard emailTextField.text!.isValidEmail() else {
            sender.shake()
            return
        }
        
        Auth().userExists(email: emailTextField.text!) { (res) in
            guard res.0 != nil else {
                return
            }
            self.email = self.emailTextField.text
            if res.0! {
                guard let window = self.view.window else { return }
                self.provider = res.1 ?? .email
                if res.1 == .google {
                    Auth().signInWithProvider(provider: .google, window: window) { res in
                        if res == .success {
                            self.checkForUserInformation(authProvider: .google)
                        } else {
                            print("Error signing In")
                        }
                    }
                } else if res.1 == .facebook {
                    Auth().signInWithProvider(provider: .facebook, window: window) { res in
                        if res == .success {
                            self.checkForUserInformation(authProvider: .facebook)
                        } else {
                            print("Error signing In")
                        }
                    }
                } else if res.1 == .apple {
                    Auth().signInWithProvider(provider: .apple, window: window) { res in
                        if res == .success {
                            self.checkForUserInformation(authProvider: .apple)
                        } else {
                            print("Error signing In")
                        }
                    }
                } else if res.1 == .email {
                    self.toEmailPassword()
                }
            } else {
                self.toCreatePassword()
            }
            
        }
        sender.pulsate()
        
    }
    
    func checkForUserInformation(authProvider: AuthenticationProvider) { // FIXME: Have to check for provider
        guard Auth().loggedIn else {
            self.presentAlert(title: AlertError.title, message: AlertError.message, button: AlertError.message)
            return
        }
        provider = authProvider
        Auth().userAttributes { (attributes) in
            if let attributeEmail = attributes?["email"] as? String {
                self.email = attributeEmail
                Auth().userExists(email: attributeEmail) { (res) in
                    if res.0 != nil {
                        !res.0! ? self.toNewUser() : self.toHome()
                    } else {
                        self.presentAlert(title: AlertError.title, message: AlertError.message, button: AlertError.message)
                    }
                }
            } else {
                self.presentAlert(title: AlertError.title, message: AlertError.message, button: AlertError.message)
            }
        }
    }
    
    @IBAction func tapGoogleSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .google, window: window) { res in
            if res == .success {
                self.checkForUserInformation(authProvider: .google)
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
                self.checkForUserInformation(authProvider: .facebook)
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
                self.checkForUserInformation(authProvider: .apple)
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
            self.performSegue(withIdentifier: Segue.toCreatePasswordFromSignIn.rawValue, sender: nil)
        }
    }
    func toEmailPassword() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toPasswordFromSign.rawValue, sender: nil)
        }
    }
    func toNewUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toNewUserFromSign.rawValue, sender: nil)
        }
    }
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toHomeFromSignIn.rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateUserViewController {
            dest.email = email
            dest.provider = provider
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
                guard res.0 != nil else {
                    return
                }
                self.email = self.emailTextField.text
                if res.0! {
                    guard let window = self.view.window else { return }
                    self.provider = res.1 ?? .email
                    if res.1 == .google {
                        Auth().signInWithProvider(provider: .google, window: window) { res in
                            if res == .success {
                                self.checkForUserInformation(authProvider: .apple)
                            } else {
                                print("Error signing In")
                            }
                        }
                    } else if res.1 == .facebook {
                        Auth().signInWithProvider(provider: .facebook, window: window) { res in
                            if res == .success {
                                self.checkForUserInformation(authProvider: .apple)
                            } else {
                                print("Error signing In")
                            }
                        }
                    } else if res.1 == .apple {
                        Auth().signInWithProvider(provider: .apple, window: window) { res in
                            if res == .success {
                                self.checkForUserInformation(authProvider: .apple)
                            } else {
                                print("Error signing In")
                            }
                        }
                    } else if res.1 == .email {
                        self.toEmailPassword()
                    }
                } else {
                    self.toCreatePassword()
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
