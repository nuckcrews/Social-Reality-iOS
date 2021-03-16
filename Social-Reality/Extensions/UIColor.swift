//
//  Colors.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

extension UIColor {
    
    static let primary = UIColor(red: 0.49, green: 0.43, blue: 1.00, alpha: 1.00)
    
    static var mainText: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00) :
                UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)
        }
    }
    
    static var grayText: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00) :
                UIColor(red: 0.57, green: 0.57, blue: 0.57, alpha: 1.00)
        }
    }
    
    static var separator: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00) :
                UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.00)
        }
    }
    
    static var background: UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ?
                UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00) :
                UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
               
        }
    }

}
