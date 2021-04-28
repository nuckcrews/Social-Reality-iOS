//
//  CreateAvatarViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import UIKit

// MARK: - Create Avatar View Controller

class CreateAvatarViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    var user: User?
    var imagePicker: ImagePicker!
    var imageURL = ProfileImage.defaultURL
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    // MARK: - User Fetching
    
    func getUser() {
        
        guard let id = Auth0.uid else { return }
        user = User(id: id)
        user?.getModel(completion: { res in
            if let res = res {
                print(res)
            } else {
                print("no date")
            }
        })
        
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
    
    // MARK: - Save Image
    
    func saveImage() {
        user?.updateModel(data: ["image": imageURL], completion: { [weak self] res in
            self?.toHome()
        })
    }
    
    // MARK: - Action Outlets
    
    @IBAction func tapEditAvatar(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        saveImage()
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Segues
    
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toHomeFromAvatar.rawValue, sender: nil)
        }
    }
    
}

// MARK: - Image Picker Delegate

extension CreateAvatarViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        self.avatarImageView.image = image
        self.uploadImage(image: image)
    }
    
    func uploadImage(image: UIImage) {
        guard let uid = Auth0.uid else { return }
        startLoading()
        
        Storage0.remote.upload.image(key: uid, image: image) { [weak self] res in
            guard let res = res else { return }
            self?.imageURL = res
            self?.stopLoading()
        }
    }
    
}




