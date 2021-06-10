//
//  PasswordViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

// MARK: - Password View Controller

class PasswordViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordIndicator: UIButton!
    
    // MARK: - Variables
    
    var email: String?
    
    struct WrongPasswordError {
        static var title = "Password Incorrect"
        static var message = "Please ensure you are logging in to the correct account"
        static var button = "Ok"
    }
    
    struct AlertError {
        static var title = "Error Signing In"
        static var message = "There could have been a mistake on our end. Please try signing in again."
        static var button = "Ok"
    }
    
    // MARK: - View Instantiation
    
    internal static func instantiate(email: String?) -> PasswordViewController? {

        guard let viewController = Storyboard.PasswordViewController.instantiate(PasswordViewController.self) else {
            return nil
        }
        
        viewController.email = email
        
        return viewController
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
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
    
    // MARK: - Sign In User
    
    func signInUser() {
        guard let email = email, let password = passwordTextField.text else { return }
        self.startLoading()
        Auth0.signIn(email: email, password: password) { [weak self] result in
            if result != nil {
                guard let id = Auth0.uid else {
                    self?.stopLoading()
                    self?.presentAlert(title: AlertError.title,
                                       message: AlertError.message,
                                       button: AlertError.button)
                    return
                }
                self?.checkUserData(id: id)
            } else {
                self?.stopLoading()
                self?.presentAlert(title: WrongPasswordError.title,
                                   message: WrongPasswordError.message,
                                   button: WrongPasswordError.button)
            }
        }
        
    }
    
    func checkUserData(id: String) {
        Auth0.userDataExists(id: id) { [weak self] res in
            self?.stopLoading()
            res ? self?.toHome() : self?.toCreateUser()
        }
    }
    
    // MARK: - Action Outlets
    
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
    
    // MARK: - Segues
    
    func toHome() {
        
        DispatchQueue.main.async {
            
            if let navController = CoverNavigationController.instantiate() {
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func toCreateUser() {
        
        DispatchQueue.main.async {
            
            if let viewController = CreateUserViewController.instantiate(email: self.email) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
    func toConfirmUser() {

        DispatchQueue.main.async {
            
            if let viewController = ConfirmUserViewController.instantiate(email: self.email, password: self.passwordTextField.text) {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
    
}

// MARK: - TextField Delegate

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
