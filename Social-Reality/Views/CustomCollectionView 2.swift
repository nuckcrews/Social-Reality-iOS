//
//  CustomCollectionView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/1/21.
//

import UIKit

class CustomCollectionView: UICollectionView {

    @IBInspectable var extraHeight: CGFloat = 0
    @IBInspectable var minimumHeight: CGFloat = 0
    @IBInspectable var minimumWidth: CGFloat = -1
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        var width = UIView.noIntrinsicMetric
        if minimumWidth > -1 {
            width = minimumWidth
        }
        if minimumHeight > contentSize.height + extraHeight {
            return CGSize(width: width, height: minimumHeight)
        } else {
            return CGSize(width: width, height: contentSize.height + extraHeight)
        }
        
    }
    
    
}

