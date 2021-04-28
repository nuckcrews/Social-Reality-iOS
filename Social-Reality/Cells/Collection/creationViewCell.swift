//
//  creationViewCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

// MARK: - Creation View Cell

class creationViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    // MARK: - Prepare for Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
    }
    
    // MARK: - Configure Methods
    
    func configure(with image: UIImage?) {
        imageView.image = image?.fixOrientation()
    }
    
    func configureCell(creation: CreationThumbNailView) {
        imageView.setImageFromURL(creation.model?.thumbnail)
    }
    
    func configureCell(creation: CreationThumbNailView, imageFrame: (CGFloat, CGFloat)) {
        imageView.setImageFromURL(creation.model?.thumbnail)
        imageViewHeight.constant = imageFrame.1
        imageViewHeight.constant = imageFrame.0
    }

}

