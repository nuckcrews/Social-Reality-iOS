//
//  CustomScrollView.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/27/21.
//

import Foundation
import UIKit

class CustomScrollView: UIScrollView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDragging {
            next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}
