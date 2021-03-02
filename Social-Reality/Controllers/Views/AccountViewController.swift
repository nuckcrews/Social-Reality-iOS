//
//  AccountViewController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/26/21.
//

import UIKit
import KRLCollectionViewGridLayout

class AccountViewController: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var contentSegement: CustomSegmentedControl! {
        didSet{
            contentSegement.setButtonTitles(buttonTitles: [("",UIImage(systemName: "square.grid.3x3")), ("",UIImage(systemName: "heart"))])
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
        
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        
        setupCollection()
        
    }
    
    func setupCollection() {
        let flowLayout = KRLCollectionViewGridLayout()
        flowLayout.aspectRatio = 1
        flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 2, bottom: 0, right: 2)
        flowLayout.interitemSpacing = 4
        flowLayout.lineSpacing = 4
        flowLayout.numberOfItemsPerLine = 3
        flowLayout.scrollDirection = .vertical
        self.contentCollectionView.collectionViewLayout = flowLayout
    }
    
    @IBAction func tapSettings(_ sender: UIButton) {
        sender.jump()
        self.performSegue(withIdentifier: "toSettingsfromAccount", sender: nil)
    }

}
extension AccountViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        let x = (index == 0) ? 0 : view.frame.width
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.contentScrollView.contentOffset.x = x
        } completion: { _ in
            print("done")
        }

    }
}
extension AccountViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainScrollView {
            if scrollView.contentOffset.y >= topView.frame.height {
                scrollView.contentOffset.y = topView.frame.height
                contentCollectionView.isScrollEnabled = true
            } else {
                contentCollectionView.isScrollEnabled = false
            }
        } else if scrollView == contentScrollView {
            if scrollView.contentOffset.x == 0 {
                contentSegement.setIndex(index: 0)
            } else if scrollView.contentOffset.x == view.frame.width {
                contentSegement.setIndex(index: 1)
            }
        } else if scrollView == contentCollectionView {
            
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    
}
extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountContentCell", for: indexPath as IndexPath) as? accountContentCell {
            return cell
        } else {
            return accountContentCell()
        }
    }
    
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {
        switch section {
        case 0: return .flow(column: 1) // single column flow layout
        case 1: return .waterfall(column: 3) // three waterfall layout
        default: return .flow(column: 2)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(...)
    }    
    
}
