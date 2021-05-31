//
//  CustomTabBar.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

class CustomTabBar: UITabBar {
    
    override func draw(_ rect: CGRect) {
        self.backgroundImage = UIImage.colorForNavBar(color: .black)
        self.shadowImage = UIImage.colorForNavBar(color: UIColor.clear)
    }
    
}
