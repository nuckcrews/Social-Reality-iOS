//
//  StoryBoard.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/3/21.
//

import UIKit

struct StoryBoard {
    
    static func viewController(type: ViewController, storyBoard: StoryBoards) -> UIViewController? {
        
        switch type {
        case .SettingsViewController:
            
            guard let viewController = UIStoryboard.init(name: storyBoard.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewController.SettingsViewController.rawValue) as? SettingsViewController else
            { return nil }
            
            return viewController
        case .EditProfileViewController:
            
            
            guard let viewController =  UIStoryboard.init(name: storyBoard.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewController.EditProfileViewController.rawValue) as? EditProfileViewController else {
                return nil
            }
            
            return viewController
            
        case .MyProfileHeader:
            
            guard let viewController =  UIStoryboard.init(name: storyBoard.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewController.MyProfileHeader.rawValue) as? MyProfileHeaderViewController else {
                return nil
            }
            
            return viewController
            
        default:
            return nil
        }
        
    }
    
}
