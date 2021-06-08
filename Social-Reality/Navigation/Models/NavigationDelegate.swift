//
//  NavigationDelegate.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/6/21.
//

import UIKit

protocol NavigationDelegate {
    
    func instantiate() -> UIViewController?
    
    func instantiate(creations: [CreationModel]) -> UIViewController?
    
    func instantiate(creations: [CreationModel], selectedIndex: Int) -> UIViewController?
    
}

extension NavigationDelegate {
    
    func instantiate() -> UIViewController? { return nil }
    
    func instantiate(creations: [CreationModel]) -> UIViewController? { return nil }
    
    func instantiate(creations: [CreationModel], selectedIndex: Int) -> UIViewController? { return nil }
    
}
