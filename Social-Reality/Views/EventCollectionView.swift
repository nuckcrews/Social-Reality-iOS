//
//  EventCollectionView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/4/21.
//

import Foundation
import UIKit

class EventCollectionView: UICollectionView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDragging {
            next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}
