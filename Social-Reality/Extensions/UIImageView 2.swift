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
    
    func setImageFromURL(_ urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
    
    func setImageFromURL(_ urlString: String?, completion: @escaping(_ result: ResultType) -> Void) {
        guard let url = URL(string: urlString ?? "") else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
//        self.kf.setImage(with: resource)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { [weak self] result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                self?.image = value.image
                completion(.success)
            case .failure(let error):
                print("Error: \(error)")
                completion(.error)
            }
        }
    }
    
}
