//
//  ProfileCreationsHeaderView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import UIKit

class ProfileCreationsHeaderView: UICollectionReusableView, InstantiatesFromNib, CustomSegmentedControlDelegate {
    
    @IBOutlet weak var contentSegment: CustomSegmentedControl! {
        didSet {
            contentSegment.setButtonTitles(buttonTitles: [
                    ("", UIImage(systemName: "square.grid.3x3.fill")),
                    ("", UIImage(named: Images.pinDrop.rawValue)),
                    ("", UIImage(systemName: "heart.fill"))
            ])
            contentSegment.selectorViewColor = .mainText
            contentSegment.selectorTextColor = .mainText
            contentSegment.textColor = .lightGray
            contentSegment.delegate = self
            contentSegment.backgroundColor = .clear
        }
    }

    func change(to index: Int) {
        print(index)
    }
    
    func setupView() {
        
    }

}
