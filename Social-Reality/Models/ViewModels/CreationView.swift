//
//  CreationView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/2/21.
//

import Foundation
import UIKit

struct CreationView {
    let id = UUID()
    let image: UIImage
}

extension CreationView: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CreationView {
    static var demoPhotos: [CreationView] {
        let names = (1...24).map({ _ in "photo" })
        print(names)
        return names.map({ CreationView(image: UIImage(named: $0)!) })
    }
    
    static var demoPhotos2: [CreationView] {
        let names = (1...8).map({ _ in "Photo2" })
        print(names)
        return names.map({ CreationView(image: UIImage(named: $0)!) })
    }
}
