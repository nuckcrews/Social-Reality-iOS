//
//  EditProfileViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/16/21.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    @IBOutlet weak var usernameIndicator: UIButton!
    @IBOutlet weak var firstNameIndicator: UIButton!
    @IBOutlet weak var lastNameIndicator: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.delegate = self
        usernameTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        bioTextView.delegate = self

        usernameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditProfileViewController: UIScrollViewDelegate {
    
}

extension EditProfileViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
