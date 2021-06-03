//
//  ProfileViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/12/21.
//

import UIKit

// MARK: - Profile View Controller -> Tab 5

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView() {
        
        guard let storyboard = storyboard else { return }
        
        guard let profileVC = storyboard
                        .instantiateViewController(withIdentifier: ViewControllers.ProfileScrollViewController.rawValue) as? ProfileScrollViewController else { return }
        
        containerView.addSubview(profileVC.view)
        addChild(profileVC)
        profileVC.didMove(toParent: self)
        
        let views: [String: UIView] = ["view": containerView, "page1": profileVC.view]
        
        let vertConsts = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
        let horzConsts = NSLayoutConstraint.constraints(withVisualFormat: "H:|[page1(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(vertConsts + horzConsts)
        
    }
    
    func toSettings() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toSettingsFromProfile.rawValue, sender: nil)
        }
    }
    
    func toContentDetail() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreationDetailFromAccount.rawValue, sender: nil)
        }
    }
    
    func toContentCollection() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Segue.toCreationCollectionFromAccount.rawValue, sender: nil)
        }
    }
    
    @IBAction func tapSettings(_ sender: UIButton) {
        
        sender.jump()
        toSettings()
        
    }
    
    
}
