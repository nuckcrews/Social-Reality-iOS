//
//  CreateUserViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var usernameTextIndicator: UIButton!
    @IBOutlet weak var firstTextIndicator: UIButton!
    @IBOutlet weak var lastTextIndicator: UIButton!
    
    @IBOutlet weak var usernameTakenLabel: UILabel!
    
    var email: String?
    
    struct AlertError {
        static var title = "Confirmation Error"
        static var message = "Please try entering the code again."
        static var button = "Ok"
    }
    
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
    
    func checkUserName() {
        guard let username = usernameTextField.text else {
            print("no username"); return
        }
        
        startLoading()
        Auth0.usernameExists(username: username) { result in
            if result {
                self.usernameTakenLabel.alpha = 1
            } else {
                self.createUser()
            }
        }
    }
    
    func createUser() {
        guard let id = Auth0.uid, let email = email else {
            self.stopLoading(); print("no user"); return
        }
        let user = UserModel(id: id,
                             username: self.usernameTextField.text ?? "NO_USERNAME",
                             status: Auth0.status.active.rawValue,
                             first: firstNameTextField.text ?? "NO_FIRST_NAME",
                             last: lastNameTextField.text ?? "",
                             lastActive: Date().rawDateString,
                             email: email,
                             image: "",
                             access: .public,
                             fcmToken: "")
        
        Query.write.user(user) { result in
            self.stopLoading()
            if result == .success {
                self.toAvatar()
            } else {
                self.presentAlert(title: AlertError.title,
                                  message: AlertError.message,
                                  button: AlertError.button)
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
