//
//  SearchLocationCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 5/31/21.
//

import UIKit

// MARK: - TableView Cell
class SearchLocationCell: UITableViewCell {
    
    // MARK: - Identifiers
    
    enum identifiers: String {
        case searchLocationCell
    }

    // MARK: - Outlets
    
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationNameTopLabel: UILabel!
    @IBOutlet weak var locationNameBottomLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    // MARK: - Variables
    
    private var selectedLocation = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configure Cell
    
    func configureCell(location: SearchLocation, selectedCell: Bool) {
        
        locationNameTopLabel.text = location.topAddress
        locationNameBottomLabel.text = location.bottomAddress
        
        selectedLocation = selectedCell
        if selectedCell {
            radioButton.tintColor = .primary
            radioButton.setImage(UIImage(systemName: "dot.square.fill"), for: .normal)
        } else {
            radioButton.tintColor = .grayText
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
    }
    
    func tapSelect() {
        if !selectedLocation {
            selectedLocation = true
            radioButton.tintColor = .primary
            radioButton.setImage(UIImage(systemName: "dot.square.fill"), for: .normal)
        } else {
            selectedLocation = false
            radioButton.tintColor = .grayText
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
}
