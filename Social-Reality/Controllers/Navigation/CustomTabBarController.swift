//
//  CustomTabBar.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import Foundation
import UIKit
import TransitionableTab

class CustomerTabBarController: UITabBarController, TransitionableTab {
    
    @IBOutlet weak var buttonBarView: UITabBar!
    
    var firstTabBarItemImageView: UIImageView!
    var secondTabBarItemImageView: UIImageView!
    var thirdTabBarItemImageView: UIImageView!
    var fourthTabBarItemImageView: UIImageView!
    var fifthTabBarItemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.buttonBarView.layer.shadowRadius = 16.0
        self.buttonBarView.layer.shadowColor = UIColor.black.cgColor
        self.buttonBarView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.buttonBarView.layer.shadowOpacity = 0.2
        self.buttonBarView.layer.masksToBounds = false
        
        if let createTab = self.tabBar.items?[2], let img = UIImage(named: Images.plusTabSmall.rawValue)?
            .withRenderingMode(.alwaysOriginal) {
            createTab.image = img.withTintColor(.primary)
            createTab.selectedImage = img
            createTab.imageInsets = UIEdgeInsets(top: 18, left: 8, bottom: 2, right: 8)
            createTab.title = nil
            
        }
        
        let firstItemView = tabBar.subviews.first!
        firstTabBarItemImageView = firstItemView.subviews.first as? UIImageView
        firstTabBarItemImageView.contentMode = .center

        let secondItemView = self.tabBar.subviews[1]
        self.secondTabBarItemImageView = secondItemView.subviews.first as? UIImageView
        self.secondTabBarItemImageView.contentMode = .center
        
//        let thirdItemView = tabBar.subviews[2]
//        thirdTabBarItemImageView = thirdItemView.subviews.first as? UIImageView
//        thirdTabBarItemImageView.contentMode = .center

        let fourthItemView = self.tabBar.subviews[2]
        self.fourthTabBarItemImageView = fourthItemView.subviews.first as? UIImageView
        self.fourthTabBarItemImageView.contentMode = .center
        
        let fifthItemView = tabBar.subviews[3]
        fifthTabBarItemImageView = fifthItemView.subviews.first as? UIImageView
        fifthTabBarItemImageView.contentMode = .center
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarItemTag = TabBarItemTag(rawValue: item.tag) else {
            return
        }

        switch tabBarItemTag {
        case .firstViewController:
            animate(firstTabBarItemImageView)
        case .secondViewController:
            animate(secondTabBarItemImageView)
        case .thirdViewController:
            if let createViewController = storyboard?.instantiateViewController(identifier: "CreateViewController") as? CreateViewController {
                self.present(createViewController, animated: true) {
                    print("Presented Creation")
                }
            }
        case .fourthViewController:
            animate(fourthTabBarItemImageView)
        case .fifthViewController:
            animate(fifthTabBarItemImageView)
        }
        
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }

    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return viewController != tabBarController.viewControllers?[2] && animateTransition(tabBarController, shouldSelect: viewController)
    }
    
}


enum TabBarItemTag: Int {
    case firstViewController = 101
    case secondViewController = 102
    case thirdViewController = 103
    case fourthViewController = 104
    case fifthViewController = 105
}
