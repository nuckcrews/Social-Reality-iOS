//
//  ProfileMapViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/16/21.
//

import UIKit
import XLPagerTabStrip
import GoogleMaps

class ProfileMapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    var selectedIndex = 0
    var pageIndex: Int = 0
    var pageTitle: String?
    var segmentImage: UIImage?
    
    // MARK: - View Instantiation
    
    internal static func instantiate() -> ProfileMapViewController? {

        guard let viewController = Storyboard.Main.instantiate(ProfileMapViewController.self) else {
            return nil
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ProfileMapViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: segmentImage?.withTintColor(.grayText), highlightedImage: segmentImage?.withTintColor(.mainText), userInfo: nil)
    
    }
}
