//
//  CoverNavigationController.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/28/21.
//

import Foundation
import UIKit

class CoverNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        self.isNavigationBarHidden = true
        setupFullWidthBackGesture()
    }
    
    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()

    private func setupFullWidthBackGesture() {
        guard
            let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
            let targets = interactivePopGestureRecognizer.value(forKey: "targets")
        else { return }

        fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
        fullWidthBackGestureRecognizer.delegate = self
        view.addGestureRecognizer(fullWidthBackGestureRecognizer)
    }
}

extension CoverNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        let isThereStackedViewControllers = viewControllers.count > 1
        return isSystemSwipeToBackEnabled && isThereStackedViewControllers
    }
}
