//
//  searchLocationCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/25/21.
//

import UIKit

class searchLocationCell: UITableViewCell {
    
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationNameTopLabel: UILabel!
    @IBOutlet weak var locationNameBottomLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!

    
    private var selectedLocation = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
