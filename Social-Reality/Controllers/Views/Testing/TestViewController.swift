//
//  TestViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/1/21.
//

import UIKit

class TestViewController: UIViewController {
    
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    
    func uploadVideo() {
        
        
    }
    
    @IBAction func tapUpload(_ sender: UIButton) {
        
       // Storage0.remote.download.video()
        
    }
    
}

extension TestViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        
        
        print(image)
    }
    
}
