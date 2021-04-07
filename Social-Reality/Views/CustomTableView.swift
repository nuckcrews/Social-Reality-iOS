//
//  CustomTableView.swift
//  Social-Reality
//
//  Created by Nick Crews on 4/7/21.
//

import Foundation
import UIKit

class CustomTableView: UITableView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDragging {
            next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}
