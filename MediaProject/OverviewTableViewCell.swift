//
//  OverviewTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/14.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    var expand: Bool = false
    var myDelegate : DownBtnClicked?
    
    
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet var downButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        overviewLabel.numberOfLines = 2
        overviewLabel.font = .systemFont(ofSize: 12)
        downButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }

    @IBAction func downButtonClicked(_ sender: UIButton) {
        expand.toggle()
        if !expand {
            overviewLabel.numberOfLines = 2
            downButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            overviewLabel.numberOfLines = 0
            downButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        myDelegate?.onDownBtnClicked()
    }
    
    
    
}

protocol DownBtnClicked {
     func onDownBtnClicked()
}
