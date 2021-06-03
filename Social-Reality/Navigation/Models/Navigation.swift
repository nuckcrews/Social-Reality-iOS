//
//  Navigation.swift
//  Social-Reality
//
//  Created by Nick Crews on 6/2/21.
//

import UIKit

// MARK: - Navigation Methods

struct Navigation {
    
    static func push(to vc: ViewController, navigationController: UINavigationController?, data: [String: Any]?) {
        
        guard let navigationController = navigationController else { return }
        
        DispatchQueue.main.async {
            
            switch vc {
            case .SettingsViewController:
                
                if let viewController = StoryBoard.viewController(type: vc, storyBoard: .main) as? SettingsViewController {
                    navigationController.pushViewController(viewController, animated: true)
                }
                
            case .EditProfileViewController:
                
                if let viewController = StoryBoard.viewController(type: vc, storyBoard: .main) as? EditProfileViewController {
                    navigationController.pushViewController(viewController, animated: true)
                }
                
            default:
                return
            }
            
        }
        
    }
    
    static func modal(to vc: ViewController, navigationController: UINavigationController?, data: [String: Any]?, style: UIModalPresentationStyle) {
        
        guard let navigationController = navigationController else { return }
        
        DispatchQueue.main.async {
            
            switch vc {
            case .SettingsViewController:
                
                if let viewController = StoryBoard.viewController(type: vc, storyBoard: .main) as? SettingsViewController {
                    viewController.modalPresentationStyle = style
                    navigationController.present(viewController, animated: true, completion: nil)
                }
                
            case .EditProfileViewController:
                
                if let viewController = StoryBoard.viewController(type: vc, storyBoard: .main) as? EditProfileViewController {
                    viewController.modalPresentationStyle = style
                    navigationController.present(viewController, animated: true, completion: nil)
                }
                
            default:
                return
            }
            
        }
        
    }
    
}
