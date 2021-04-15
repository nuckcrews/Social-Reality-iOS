//
//  ProfileViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/12/21.
//

import UIKit
import SJSegmentedScrollView

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var segmentedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }

    func setupView() {
        
        guard let storyboard = storyboard else { return }
        
        guard let profileHeaderViewController = storyboard
                .instantiateViewController(withIdentifier: ViewControllers.MyProfileHeader.rawValue) as? MyProfileHeaderViewController else { return }
        
        profileHeaderViewController.userID = Auth0.uid

        let creationCollectionViewController = storyboard
            .instantiateViewController(withIdentifier: ViewControllers.CreationCollection.rawValue)
        creationCollectionViewController.title = "Creations"
        
        let creationCollectionViewController2 = storyboard
            .instantiateViewController(withIdentifier: ViewControllers.CreationCollection.rawValue)
        creationCollectionViewController2.title = "Second"

        let segmentedViewController = SJSegmentedViewController(headerViewController: profileHeaderViewController,
        segmentControllers: [creationCollectionViewController,
                             creationCollectionViewController2])
        
        segmentedViewController.segmentShadow = .light()
        segmentedViewController.segmentTitleColor = .mainText
        segmentedViewController.segmentViewHeight = 44
        segmentedViewController.selectedSegmentViewColor = .mainText
        segmentedViewController.selectedSegmentViewHeight = 1
        segmentedViewController.headerViewOffsetHeight = 0
        segmentedViewController.headerViewHeight = 288
        segmentedViewController.segmentedScrollViewColor = .background
        segmentedViewController.showsVerticalScrollIndicator = false
        segmentedViewController.showsHorizontalScrollIndicator = false
        segmentedViewController.segmentBounces = true
        
        segmentedViewController.delegate = self
        
        segmentedView.addSubview(segmentedViewController.view)
        addChild(segmentedViewController)
        segmentedViewController.didMove(toParent: self)
        
        let views: [String: UIView] = ["view": segmentedView, "page1": segmentedViewController.view]
        
        let vertConsts = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page1(==view)]|", options: [], metrics: nil, views: views)
        let horzConsts = NSLayoutConstraint.constraints(withVisualFormat: "H:|[page1(==view)]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
       
       
        NSLayoutConstraint.activate(vertConsts + horzConsts)
        
    }

}

extension ProfileViewController: SJSegmentedViewControllerDelegate {
    
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        print(index)
    }
    
}
