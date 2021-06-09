//
//  NavigationController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit

final class NavigationController: UINavigationController {
    
    // MARK: - Identifiers
    
    enum identifiers: String {
        case MainNavigationController
        case ExploreNavigationController
        case CreateNavigationController
        case InboxNavigationController
        case ProfileNavigationController
    }
    
    // MARK: - View Instantiation
    
    internal static func instantiate(id: identifiers) -> NavigationController? {
        
        switch id {
        case .MainNavigationController:
            guard let navigationController = Storyboard.MainViewController.instantiate(NavigationController.self, identifier: id.rawValue) else {
                return nil
            }
            
            return navigationController
        case .ExploreNavigationController:
            guard let navigationController = Storyboard.ExploreViewController.instantiate(NavigationController.self, identifier: id.rawValue) else {
                return nil
            }
            
            return navigationController
        case .CreateNavigationController:
            guard let navigationController = Storyboard.CreateViewController.instantiate(NavigationController.self, identifier: id.rawValue) else {
                return nil
            }
            
            return navigationController
        case .InboxNavigationController:
            guard let navigationController = Storyboard.InboxViewController.instantiate(NavigationController.self, identifier: id.rawValue) else {
                return nil
            }
            
            return navigationController
        case .ProfileNavigationController:
            guard let navigationController = Storyboard.ProfileViewController.instantiate(NavigationController.self, identifier: id.rawValue) else {
                return nil
            }
            
            return navigationController
        }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        self.isNavigationBarHidden = true
        setupFullWidthBackGesture()
    }
    
    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
    
    private func setupFullWidthBackGesture() {
        guard
            let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
            let targets = interactivePopGestureRecognizer.value(forKey: "targets")
        else { return }
        
        fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
        fullWidthBackGestureRecognizer.delegate = self
        view.addGestureRecognizer(fullWidthBackGestureRecognizer)
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        let isThereStackedViewControllers = viewControllers.count > 1
        return isSystemSwipeToBackEnabled && isThereStackedViewControllers
    }
}
