//
//  CreatePasswordViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

// MARK: - Create Password View Controller

class CreatePasswordViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterTextField: UITextField!
    @IBOutlet weak var passwordRequirementsLabel: UILabel!
    
    @IBOutlet weak var passwordIndicator: UIButton!
    @IBOutlet weak var reenterIndicator: UIButton!
    
    // MARK: - Variables
    
    var email: String?
    var username: String?
    var first: String?
    var last: String?
    
    struct AlertError {
        static var title = "Error Signing Up"
        static var message = "There could have been a mistake on our end. Please try signing up again."
        static var button = "Ok"
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        reenterTextField.delegate = self
        
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        reenterTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
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
    
    // MARK: - Sign Up Functionality
    
    func signUpUser() {
        guard let password = passwordTextField.text, let email = email else {
            return
        }
        self.startLoading()
        Auth0.signUp(email: email, password: password) { [weak self] result in
            if result != nil {
                self?.stopLoading()
                self?.toCreateUser()
            } else {
                self?.stopLoading()
                self?.presentAlert(title: AlertError.title,
                                  message: AlertError.message,
                                  button: AlertError.button)
            }
        }
        
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapContinue(_ sender: UIButton) {
        guard passwordTextField.text != nil, passwordTextField.text!.isValidPassword() else {
            passwordRequirementsLabel.textColor = .red
            sender.shake()
            return
        }
        if passwordTextField.text != "" && passwordTextField.text == reenterTextField.text {
            sender.pulsate()
            signUpUser()
        } else {
            sender.shake()
        }
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Segues
    
    func toConfirmUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toConfirmUserFromCreatePassword.rawValue, sender: nil)
        }
    }
    
    func toCreateUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreateUserFromPassword.rawValue, sender: nil)
        }
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

// MARK: - TextField Delegate

extension CreatePasswordViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == passwordTextField {
            if textField.text!.isValidPassword() {
                passwordIndicator.tintColor = .systemGreen
            } else {
                passwordIndicator.tintColor = .grayText
            }
        } else {
            if textField.text!.isValidPassword() {
                reenterIndicator.tintColor = .systemGreen
            } else {
                reenterIndicator.tintColor = .grayText
            }
        }
        passwordRequirementsLabel.textColor = .grayText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            reenterTextField.becomeFirstResponder()
            return false
        } else {
            guard passwordTextField.text != nil, passwordTextField.text!.isValidPassword() else {
                passwordRequirementsLabel.textColor = .red
                return true
            }
            
            if passwordTextField.text != "" && passwordTextField.text == reenterTextField.text {
                signUpUser()
            }
            return true
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
