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
    @IBOutlet weak var usernameTopButton: UIButton!
    
    var user: UserModel?
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> ProfileViewController? {

        guard let viewController = Storyboard.Main.instantiate(ProfileViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getUser()
        
    }
    
    func setupView() {
        
        guard let storyboard = storyboard else { return }
        
        guard let profileVC = storyboard
                        .instantiateViewController(withIdentifier: ViewController.ProfileScrollViewController.rawValue) as? ProfileScrollViewController else { return }
        
        containerView.addSubview(profileVC.view)
        addChild(profileVC)
        profileVC.didMove(toParent: self)
        
        let views: [String: UIView] = ["view": containerView, "page1": profileVC.view]
        
        let vertConsts = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
        let horzConsts = NSLayoutConstraint.constraints(withVisualFormat: "H:|[page1(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(vertConsts + horzConsts)
        
    }
    
    func getUser() {
        
        guard let uid = Auth0.uid else { return }
        
        if let model = Query.defaults.get.user(uid) {
            user = model
            usernameTopButton.setTitle(model.username, for: .normal)
        }
        
        Query.subscribe.user(uid) { [weak self] model, lstn in
            guard let model = model else { return }
            if self?.user != model {
                self?.usernameTopButton.setTitle(model.username, for: .normal)
                Query.defaults.write.user(model)
                self?.user = model
            }
            
        }
        
    }
    
    func toSettings() {
        
        DispatchQueue.main.async {
            
            if let viewController = SettingsViewController.instantiate() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
        
    }
        
    @IBAction func tapSettings(_ sender: UIButton) {
        
        sender.jump()
        toSettings()
        
    }
    
    
}
