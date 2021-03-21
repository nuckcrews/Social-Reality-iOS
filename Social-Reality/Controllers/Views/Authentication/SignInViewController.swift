//
//  SignInViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices
import CryptoKit


class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIndicatorButton: UIButton!
    
    var email: String?
    
    var loginButton = FBLoginButton()
    var googleButton: GIDSignInButton?
    var currentNonce: String?
    
    struct AlertError {
        static var title = "Error Signing In"
        static var message = "There could have been a mistake on our end. Please try signing in again."
        static var button = "Ok"
    }
    
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
        
        Buzz.light()
        sender.pulsate()
        
        checkUser(text: emailTextField.text!)
        
    }
    
    func checkUser(text: String) {
        Auth0.userExists(email: text, completion: { result in
            if let result = result {
                result ? self.toEmailPassword() : self.toCreatePassword()
            }
        })
    }
    
    
    func checkUserData(id: String) {
        Auth0.userDataExists(id: id) { result in
            result ? self.toHome() : self.toNewUser()
        }
    }
    

    @IBAction func tapGoogleSignIn(_ sender: UIButton) {
        Buzz.light()
        sender.pulsate()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func tapFacebookSignIn(_ sender: UIButton) {
        Buzz.light()
        sender.pulsate()
        loginButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func tapAppleSignIn(_ sender: UIButton) {
        Buzz.light()
        sender.pulsate()
        appleSignIn()
    }
    
    func appleSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        // Generate nonce for validation after authentication successful
        self.currentNonce = Crypto.randomNonceString()
        // Set the SHA256 hashed nonce to ASAuthorizationAppleIDRequest
        request.nonce = Crypto.sha256(currentNonce!) 
        
        // Present Apple authorization form
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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
        }
        if let dest = segue.destination as? CreatePasswordViewController {
            dest.email = emailTextField.text
        }
        if let dest = segue.destination as? PasswordViewController {
            dest.email = emailTextField.text
        }
    }
    
}

extension SignInViewController {
    
    
    func signInWithProvider(credential: AuthCredential) {
        Auth0.signInWithProvider(credential: credential) { result in
            if result == nil {
                self.presentAlert(title: AlertError.title, message: AlertError.message, button: AlertError.button)
            } else {
                self.email = result?.user.email
                self.checkUserData(id: result!.user.uid)
            }
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
            return true
        } else {
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension SignInViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        signInWithProvider(credential: credential)
    }
    
}

extension SignInViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        if AccessToken.current != nil && result != nil {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            signInWithProvider(credential: credential)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loggedOut")
    }
    
}

extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Do something with the credential...
            UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            // Retrieve Apple identity token
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Failed to fetch identity token")
                return
            }
            // Convert Apple identity token to string
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Failed to decode identity token")
                return
            }
            // Initialize a Firebase credential using secure nonce and Apple identity token
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            signInWithProvider(credential: credential)
        }
    }
    
}
