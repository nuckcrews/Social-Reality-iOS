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
    
    var firstTabbarItemImageView: UIImageView!
    var secondTabbarItemImageView: UIImageView!
    var thirdTabbarItemImageView: UIImageView!
    var fourthTabbarItemImageView: UIImageView!
    var fifthTabbarItemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.buttonBarView.layer.shadowRadius = 10.0
        self.buttonBarView.layer.shadowColor = UIColor.black.cgColor
        self.buttonBarView.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.buttonBarView.layer.shadowOpacity = 0.3
        self.buttonBarView.layer.masksToBounds = false
        
//        for i in 0 ..< self.tabBar.items!.count {
//            switch i {
//            case 2:
//                let createTab = self.tabBar.items![i] as UITabBarItem
//                let img = UIImage(systemName: "plus.rectangle.on.rectangle.fill")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//                createTab.image = img
//                createTab.selectedImage = img
//                createTab.imageInsets = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
//                createTab.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
//            default:
//                break
//            }
//        }
        
        let firstItemView = tabBar.subviews.first!
        firstTabbarItemImageView = firstItemView.subviews.first as? UIImageView
        firstTabbarItemImageView.contentMode = .center

        let secondItemView = self.tabBar.subviews[1]
        self.secondTabbarItemImageView = secondItemView.subviews.first as? UIImageView
        self.secondTabbarItemImageView.contentMode = .center
        
        let thirdItemView = tabBar.subviews[2]
        thirdTabbarItemImageView = thirdItemView.subviews.first as? UIImageView
        thirdTabbarItemImageView.contentMode = .center

        let fourthItemView = self.tabBar.subviews[3]
        self.fourthTabbarItemImageView = fourthItemView.subviews.first as? UIImageView
        self.fourthTabbarItemImageView.contentMode = .center
        
        let fifthItemView = tabBar.subviews.last!
        fifthTabbarItemImageView = fifthItemView.subviews.first as? UIImageView
        fifthTabbarItemImageView.contentMode = .center
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabbarItemTag = TabbarItemTag(rawValue: item.tag) else {
            return
        }

        switch tabbarItemTag {
        case .firstViewController:
            animate(firstTabbarItemImageView)
        case .secondViewConroller:
            animate(secondTabbarItemImageView)
        case .thirdViewConroller:
            animate(thirdTabbarItemImageView)
        case .fourthViewConroller:
            animate(fourthTabbarItemImageView)
        case .fifthViewConroller:
            animate(fifthTabbarItemImageView)
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
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
    
}


enum TabbarItemTag: Int {
    case firstViewController = 101
    case secondViewConroller = 102
    case thirdViewConroller = 103
    case fourthViewConroller = 104
    case fifthViewConroller = 105
}
