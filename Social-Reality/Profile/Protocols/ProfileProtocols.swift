//
//  ProfileProtocols.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/15/21.
//

import UIKit

protocol PanProgressDelegate: AnyObject {
    
    func scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat)
    func scrollViewDidLoad(_ scrollView: UIScrollView)
    
}

protocol ScrollDataSource: AnyObject {
    
    func headerViewController() -> UIViewController
    func bottomViewController() -> UIViewController & PagerAwareProtocol
    func minHeaderHeight() -> CGFloat
}


protocol PanViewsProtocol {
    func panView() -> UIView
}


protocol PagerAwareProtocol: AnyObject {
    
    var pageDelegate: BottomPageDelegate? { get set }
    var currentViewController: UIViewController? { get }
    var pagerTabHeight: CGFloat? { get }
    
}

protocol BottomPageDelegate: AnyObject {
    
    func pageViewController(_ currentViewController: UIViewController?, didSelectPageAt index: Int)
}

extension UIViewController: PanViewsProtocol {
    
    @objc open func panView() -> UIView{
        if let scroll = self.view.subviews.first(where: {$0 is UIScrollView}){
            return scroll
        }else{
            return self.view
        }
    }
    
}
