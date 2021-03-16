//
//  UIImageView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/15/21.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    
    func setImageFromURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
    
}
