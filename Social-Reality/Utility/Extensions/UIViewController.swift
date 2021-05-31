//
//  UIViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/15/21.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController, to: UIView? = nil, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        if let toView = to{
            toView.addSubview(child.view)
        }else{
            view.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    var bottomInset: CGFloat{
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return bottomLayoutGuide.length
        }
    }
    
    var topInset: CGFloat{
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        } else {
            return topLayoutGuide.length
        }
    }
    
    func configurePan(with dataSource: ScrollDataSource, delegate: PanProgressDelegate? = nil) {
        let vc = ProfilePanViewController()
        vc.dataSource = dataSource
        vc.delegate = delegate
        self.add(vc)
        vc.view.pinEdges(to: self.view)
    }
    
}


