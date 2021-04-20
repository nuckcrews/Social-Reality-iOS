//
//  creationViewCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

class creationViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
    }
    
    func configure(with image: UIImage?) {
        imageView.image = image?.fixOrientation()
    }
    
    func configureCell(creation: CreationThumbNailView) {
        imageView.setImageFromURL(creation.model?.thumbnail)
//        imageViewHeight.isActive = false
//        imageViewWidth.isActive = false
    }
    
    func configureCell(creation: CreationThumbNailView, imageFrame: (CGFloat, CGFloat)) {
        imageView.setImageFromURL(creation.model?.thumbnail)
        imageViewHeight.constant = imageFrame.1
        imageViewHeight.constant = imageFrame.0
    }

}

