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

// MARK: - Sign In View Controller

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIndicatorButton: UIButton!
    
    // MARK: - Variables
    
    var email: String?
    
    var loginButton = FBLoginButton()
    var googleButton: GIDSignInButton?
    var currentNonce: String?
    
    struct AlertError {
        static var title = "Error Signing In"
        static var message = "There could have been a mistake on our end. Please try signing in again."
        static var button = "Ok"
    }
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> SignInViewController? {
        
        guard let viewController = Storyboard.Main.instantiate(SignInViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    // MARK: - View Lifecycle
    
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
    
    // MARK: - Loading Animations
    
    func startLoading() {
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.loadingIndicator)
            self.loadingIndicator.alpha = 1
            self.loadingIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.alpha = 0
        }
    }
    
    // MARK: - Alert Presenter
    
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
    
    // MARK: - Check User Data
    
    func checkUser(text: String) {
        self.startLoading()
        Auth0.userExists(email: text, completion: { [weak self] result in
            if let result = result {
                self?.stopLoading()
                result ? self?.toEmailPassword() : self?.toCreatePassword()
            }
        })
    }
    
    func checkUserData(id: String) {
        Auth0.userDataExists(id: id) { [weak self] result in
            self?.stopLoading()
            result ? self?.toHome() : self?.toNewUser()
        }
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapEmailContinue(_ sender: UIButton) {
        
        guard emailTextField.text!.isValidEmail() else {
            sender.shake()
            return
        }
        
        Buzz.light()
        sender.pulsate()
        
        checkUser(text: emailTextField.text!)
        
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
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Segues
    
    func toCreatePassword() {
        
        DispatchQueue.main.async {
            
            if let viewController = CreatePasswordViewController.instantiate(email: self.emailTextField.text) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toEmailPassword() {
        
        DispatchQueue.main.async {
            
            if let viewController = PasswordViewController.instantiate(email: self.emailTextField.text) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toNewUser() {
        
        DispatchQueue.main.async {
            
            if let viewController = CreateUserViewController.instantiate(email: self.email) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toHome() {
        
        DispatchQueue.main.async {
            
            if let navController = CoverNavigationController.instantiate() {
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            
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

// MARK: - Sign In Extension

extension SignInViewController {
    
    func signInWithProvider(credential: AuthCredential) {
        self.startLoading()
        Auth0.signInWithProvider(credential: credential) { [weak self] result in
            if result == nil {
                self?.stopLoading()
                self?.presentAlert(title: AlertError.title, message: AlertError.message, button: AlertError.button)
            } else {
                self?.email = result?.user.email
                self?.checkUserData(id: result!.user.uid)
            }
        }
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
    
}

// MARK: - TextField Delegate

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

// MARK: - GIDSignIn Delegate

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

// MARK: - FBSDK Delegate

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

// MARK: - Apple SignIn

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
