//
//  creationViewCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

class creationViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -1),
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 1),
            contentView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -1),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 1)
        ])
    }
    
}

