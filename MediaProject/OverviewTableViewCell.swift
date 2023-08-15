//
//  OverviewTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/14.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    var expand: Bool = false
    
    
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet var downButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overviewLabel.numberOfLines = 2
        overviewLabel.font = .systemFont(ofSize: 12)
        downButton.addTarget(self, action: #selector(downButtonClicked), for: .touchUpInside)
        
    }

    @IBAction func downButtonClicked(_ sender: UIButton) {
        if !expand {
            overviewLabel.numberOfLines = 2
            downButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            expand = true
        } else {
            overviewLabel.numberOfLines = 0
            downButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            expand = false
        }
    }
    
    
}
