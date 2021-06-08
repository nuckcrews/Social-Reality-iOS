//
//  SettingsCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 2/27/21.
//

import UIKit

// MARK: - Settings Cell

class SettingsCell: UITableViewCell {
    
    // MARK: - Identifiers
    
    enum identifiers: String {
        case settingsCell
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure Methods
    
    func configureCell(title: String, index: Int) {
        titleLabel.text = title
        if index == 5 {
            titleLabel.textColor = .red
        }
    }
    
}
