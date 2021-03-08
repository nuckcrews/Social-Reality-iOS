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
    
    var loginButton: FBLoginButton!
    var googleBtn: GIDSignInButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        loginButton.isHidden = true

    }
    
    
    @IBAction func tapEmailContinue(_ sender: UIButton) {
        
        if emailTextField.text!.isValidEmail() {
            Auth().userExists(email: emailTextField.text!) { (res) in
                if res != nil {
                    !res! ? self.performSegue(withIdentifier: "toPasswordfromSign", sender: nil) : self.performSegue(withIdentifier: "toNewUserfromSign", sender: nil)
                }
            }
            sender.pulsate()
        } else {
            sender.shake()
        }
        
    }
    
    @IBAction func tapGoogleSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .google, window: window) { res in
            print(res)
        }
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func tapFacebookSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .facebook, window: window) { res in
            print(res)
        }
//        loginButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func tapAppleSignIn(_ sender: UIButton) {
        sender.pulsate()
        guard let window = view.window else { return }
        Auth().signInWithProvider(provider: .apple, window: window) { res in
            print(res)
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateUserViewController {
            dest.email = emailTextField.text
        }
        if let dest = segue.destination as? PasswordViewController {
            dest.email = emailTextField.text
        }
    }
    
    
}

extension SignInViewController: LoginButtonDelegate, GIDSignInDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged Out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if AccessToken.current != nil && result != nil {
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let error = error else { return }
        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        self.firCredential = credential
//        self.userEmail = user.profile.email
//        self.signSocial()
        
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
                    res! ? self.performSegue(withIdentifier: "toPasswordfromSign", sender: nil) : self.performSegue(withIdentifier: "toNewUserfromSign", sender: nil)
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
