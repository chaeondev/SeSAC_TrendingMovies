//
//  CastTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/14.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    

    @IBOutlet var personImageView: UIImageView!
    @IBOutlet var realNameLabel: UILabel!
    @IBOutlet var roleNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        realNameLabel.font = .boldSystemFont(ofSize: 15)
        roleNameLabel.font = .systemFont(ofSize: 14)
        roleNameLabel.textColor = .gray
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
