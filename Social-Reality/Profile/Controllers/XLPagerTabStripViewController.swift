//
//  XLPagerTabStripViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/15/21.
//

import UIKit
import XLPagerTabStrip

class XLPagerTabStripViewController: ButtonBarPagerTabStripViewController, PagerAwareProtocol {
    
    //MARK: PagerAwareProtocol
    weak var pageDelegate: BottomPageDelegate?
    
    var currentViewController: UIViewController?{
        return viewControllers[currentIndex]
    }
    
    var pagerTabHeight: CGFloat?{
        return 160
    }

    //MARK: Properties
    var isReload = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settings.style.buttonBarBackgroundColor = .background
        settings.style.buttonBarItemBackgroundColor = .background
        settings.style.selectedBarBackgroundColor = .mainText
        settings.style.buttonBarItemTitleColor = .mainText
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarMinimumLineSpacing = 12
    }

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        self.changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            oldCell?.label.textColor = .grayText
            newCell?.label.textColor = .mainText
        }
    }

    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.CreationCollection.rawValue) as! CreationCollectionViewController
        vc.pageIndex = 0
        vc.pageTitle = "Posts"
        vc.segmentImage = UIImage(systemName: "square.grid.3x3.fill")
        let child_1 = vc
        
        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.ProfileMap.rawValue) as! ProfileMapViewController
        vc1.pageIndex = 1
        vc1.pageTitle = "Locs"
        vc1.segmentImage = UIImage(named: Images.pinDrop.rawValue)
        let child_2 = vc1
        
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.CreationCollection.rawValue) as! CreationCollectionViewController
        vc2.pageIndex = 2
        vc2.pageTitle = "Likes"
        vc2.segmentImage = UIImage(systemName: "heart.fill")
        let child_3 = vc2

        return [child_1, child_2, child_3]
    }

    override func reloadPagerTabStripView() {
        pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        super.reloadPagerTabStripView()
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        
        guard indexWasChanged == true else { return }

        //IMPORTANT!!!: call the following to let the master scroll controller know which view to control in the bottom section
        self.pageDelegate?.pageViewController(self.currentViewController, didSelectPageAt: toIndex)

    }
}
