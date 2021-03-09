//
//  CreateAvatarViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/8/21.
//

import UIKit

class CreateAvatarViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var user: User?
    var imagePicker: ImagePicker!
    var imageURL = ProfileImage.defaultURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = Auth().user?.userId {
            user = User(id: uid, subscribe: false, completion: { (result) in
                print(result)
            })
        }
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
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
    
    func saveImage() {
        if var model = user?.model {
            model.image = imageURL
            Query.api.update.user(model) { (result) in
                if result == .success {
                    self.toHome()
                } else {
                    print("Error saving data")
                }
            }
        }
    }
    
    func toPassword() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toHomefromAvatar", sender: nil)
        }
    }
    
    func toHome() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toHomefromAvatar", sender: nil)
        }
    }
    
    @IBAction func tapEditAvatar(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func tapContinue(_ sender: UIButton) {
        saveImage()
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension CreateAvatarViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.avatarImageView.image = image
            self.uploadImage(image: image)
        }
    }
    func uploadImage(image: UIImage) {
        if let uid = Auth().user?.userId {
            startLoading()
            Storage.upload.image(key: uid, image: image) { (result) in
                if result == .success {
                    Storage.download.imageURL(key: uid) { (url) in
                        if let url = url {
                            print(url.absoluteString)
                            self.imageURL = url.absoluteString
                            self.stopLoading()
                        }
                    }
                }
            }
        }
    }
}



