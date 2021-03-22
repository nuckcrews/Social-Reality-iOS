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
    
    func configure(with image: UIImage) {
        imageView.image = image
    }

}

