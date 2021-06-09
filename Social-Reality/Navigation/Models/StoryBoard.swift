//
//  StoryBoard.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/3/21.
//

import UIKit

public enum Storyboard: String {
    
    case Main
    case MainViewController
    case ExploreViewController
    case CreateViewController
    case InboxViewController
    case ProfileViewController

    public func instantiate<VC: UIViewController>(_ viewController: VC.Type, identifier: String) -> VC? {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: identifier) as? VC
            else { return nil }

        return vc
    }
    
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC? {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { return nil }

        return vc
    }

    public func instantiateInitialVC() -> UIViewController? {

        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() else {
            return nil
        }

        return vc
    }
    
}

extension UIViewController {
    
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
}
