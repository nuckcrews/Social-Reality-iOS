//
//  CreationViewCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

// MARK: - Creation View Cell

class CreationViewCell: UICollectionViewCell {

    // MARK: - Identifiers
    
    enum identifiers: String {
        case creationViewCell
    }

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    // MARK: - Variables
    
    weak var delegate: CreationViewDelegate?
    var index = 0
    
    // MARK: - Prepare for Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
    }
    
    // MARK: - Configure Methods
    
    func configure(with image: UIImage?) {
        imageView.backgroundColor = .systemGray4
        imageView.image = image?.fixOrientation()
    }
    
    func configureCell(at row: Int, creation: CreationThumbNailView, del: CreationViewDelegate? = nil) {
        imageView.backgroundColor = .systemGray4
        imageView.setImageFromURL(creation.model?.thumbnail)
        delegate = del
        index = row
    }
    
    func configureCell(at row: Int, creation: CreationThumbNailView, imageFrame: (CGFloat, CGFloat), del: CreationViewDelegate? = nil) {imageView.backgroundColor = .systemGray4
        imageView.setImageFromURL(creation.model?.thumbnail)
        imageViewHeight.constant = imageFrame.1
        imageViewHeight.constant = imageFrame.0
        delegate = del
        index = row
    }
    
    @IBAction func tapView(_ sender: UIButton) {
        
        delegate?.tappedView(index: index)
        
    }

}

protocol CreationViewDelegate: AnyObject {
    func tappedView(index: Int)
}

