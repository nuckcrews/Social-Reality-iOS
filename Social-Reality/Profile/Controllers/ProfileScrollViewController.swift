//
//  ProfileScrollViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/15/21.
//

import UIKit

class ProfileScrollViewController: UIViewController {

    var headerVC: MyProfileHeaderViewController?
    var bottomVC: XLPagerTabStripViewController!
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> ProfileScrollViewController? {

        guard let viewController = Storyboard.Main.instantiate(ProfileScrollViewController.self) else {
            return nil
        }
        
        return viewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }

    func setupView() {
        
       configurePan(with: self, delegate: self)
        
    }

}

extension ProfileScrollViewController: UIScrollViewDelegate {
    
}

extension ProfileScrollViewController: ScrollDataSource, PanProgressDelegate {
    
    func headerViewController() -> UIViewController {
        headerVC = MyProfileHeaderViewController.instantiate()
        headerVC?.userID = Auth0.uid
        return headerVC!
    }
    
    func bottomViewController() -> UIViewController & PagerAwareProtocol {
        bottomVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.XLPagerTabStripViewController.rawValue) as? XLPagerTabStripViewController
        return bottomVC
    }
    
    func minHeaderHeight() -> CGFloat {
        return (topInset + 0)
    }
    
    func scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
        headerVC?.update(with: progress, minHeaderHeight: minHeaderHeight())
    }
    
    func scrollViewDidLoad(_ scrollView: UIScrollView) {
        print("view loaded")
    }
    
}



