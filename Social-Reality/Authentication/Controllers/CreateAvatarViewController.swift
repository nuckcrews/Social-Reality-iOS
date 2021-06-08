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
    
    var user: UserModel?
    var imagePicker: ImagePicker!
    var imageURL = ProfileImage.defaultURL
    
    // MARK: - View Instantiation
    
    internal static func instantiate(model: UserModel?) -> CreateAvatarViewController? {

        guard let viewController = Storyboard.Main.instantiate(CreateAvatarViewController.self) else {
            return nil
        }
        
        viewController.user = model
        
        return viewController
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    // MARK: - User Fetching
    
    func getUser() {
        
        guard let uid = Auth0.uid else { return }
        
        Query.get.user(uid) { [weak self] model in
            guard let model = model else { return }
            if self?.user != model {
                Query.defaults.write.user(model)
                self?.user = model
            }
        }
        
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
        
        guard let id = user?.id else { return }
        
        Query.update.user(id, data: ["image": imageURL]) { [weak self] _ in
            self?.toHome()
        }

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
            
            if let viewController = CoverViewController.instantiate() {
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.present(viewController, animated: true, completion: nil)
            }
            
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




