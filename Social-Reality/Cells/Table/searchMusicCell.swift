//
//  searchMusicCell.swift
//  Social-Reality
//
//  Created by Nick Crews on 3/26/21.
//

import UIKit

class searchMusicCell: UITableViewCell {

    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var musicArtistLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    private var selectedMusic = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(music: String, selectedCell: Bool) {
        
        
        selectedMusic = selectedCell
        
        if selectedCell {
            radioButton.tintColor = .primary
            radioButton.setImage(UIImage(systemName: "dot.square.fill"), for: .normal)
        } else {
            radioButton.tintColor = .grayText
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
    }
    
    func tapSelect() {
        if !selectedMusic {
            selectedMusic = true
            radioButton.tintColor = .primary
            radioButton.setImage(UIImage(systemName: "dot.square.fill"), for: .normal)
        } else {
            selectedMusic = false
            radioButton.tintColor = .grayText
            radioButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
}
