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
    let image: UIImage?
}

extension CreationThumbNailView: Hashable {
    
    static func == (lhs: CreationThumbNailView, rhs: CreationThumbNailView) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CreationThumbNailView {
    
    static var demoPhotos: [CreationThumbNailView] {
        let names = (1...24).map({ _ in "photo" })
        print(names)
        return names.map({ CreationThumbNailView(model: nil, image: UIImage(named: $0)!) })
    }
    
    static var demoPhotos2: [CreationThumbNailView] {
        let names = (1...8).map({ _ in "Photo2" })
        print(names)
        return names.map({ CreationThumbNailView(model: nil, image: UIImage(named: $0)!) })
    }
}


