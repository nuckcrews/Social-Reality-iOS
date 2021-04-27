//
//  ConfirmUserViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/16/21.
//

import UIKit

// MARK: - Confirm User View Controller - DEPRECATED

class ConfirmUserViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var confirmationTextField: UITextField!
    @IBOutlet weak var confirmationIndicator: UIButton!
    
    // MARK: - Variables
    
    var email: String?
    var password: String?
    
    struct AlertError {
        static var title = "Confirmation Error"
        static var message = "Please try entering the code again."
        static var button = "Ok"
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationTextField.delegate = self
        confirmationTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
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
    
    // MARK: - Action Outlets
    
    @IBAction func tapContinue(_ sender: UIButton) {
        if confirmationTextField.text?.count ?? 0 == 6 {
            sender.pulsate()
            
//            confirmUser()
            
        } else {
            sender.shake()
        }
        
    }
    
    // MARK: - Segues
    
    func toCreateUser() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreateUserFromConfirm.rawValue, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CreateUserViewController {
            dest.email = email
        }
    }

}

// MARK: - TextField Delegate

extension ConfirmUserViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 >= 6 {
            confirmationIndicator.tintColor = .systemGreen
        } else {
            confirmationIndicator.tintColor = .grayText
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 6
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
