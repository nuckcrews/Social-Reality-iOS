//
//  UITableView.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/28/21.
//

import UIKit

extension UITableView {

    func scrollToBottom() {

        DispatchQueue.main.async {
            
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            
            if indexPath.row > 0 && self.hasRowAtIndexPath(indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: false)
           }
        }
        
    }

    func hasRowAtIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section) && indexPath.row >= 0
    }
    
}
