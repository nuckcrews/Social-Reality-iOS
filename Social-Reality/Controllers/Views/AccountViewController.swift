//
//  AccountViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentSegement: CustomSegmentedControl! {
        didSet{
            contentSegement.setButtonTitles(buttonTitles: ["Notifications","Messages"])
            contentSegement.selectorViewColor = .mainText
            contentSegement.selectorTextColor = .mainText
            contentSegement.textColor = .lightGray
            contentSegement.delegate = self
            
            contentSegement.backgroundColor = .clear
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.tag = TabbarItemTag.fifthViewConroller.rawValue
        
        mainScrollView.delegate = self
        contentScrollView.delegate = self
        
    }
    
    @IBAction func tapSettings(_ sender: UIButton) {
        sender.jump()
        self.performSegue(withIdentifier: "toSettingsfromAccount", sender: nil)
    }

}
extension AccountViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        //
    }
}
extension AccountViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainScrollView {
            if scrollView.contentOffset.y >= topView.frame.height {
                scrollView.contentOffset.y = topView.frame.height
            }
        }
    }
}
