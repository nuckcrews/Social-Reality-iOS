//
//  InstantiatesFromNib.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

protocol InstantiatesFromNib: AnyObject { 
    func setupView()
}

extension InstantiatesFromNib where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }

    static func instanceFromNib() -> Self {
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! Self
        view.setupView()
        return view
    }
    
    func setupView() {
        
        
    }
    
}
