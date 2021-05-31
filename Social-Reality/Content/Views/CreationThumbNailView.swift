//
//  CreationThumbNailView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

struct CreationThumbNailView {
    let id = UUID().uuidString
    let model: CreationModel?
}

extension CreationThumbNailView: Hashable {
    
    static func == (lhs: CreationThumbNailView, rhs: CreationThumbNailView) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



