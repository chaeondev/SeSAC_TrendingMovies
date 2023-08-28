//
//  HeaderSeasonCollectionReusableView.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/18.
//

import UIKit

class HeaderSeasonCollectionReusableView: UICollectionReusableView {

    @IBOutlet var seasonBackDropImageView: UIImageView!
    @IBOutlet var seasonTitleLabel: UILabel!
    @IBOutlet var seasonOverviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .black.withAlphaComponent(0.6)
        seasonBackDropImageView.contentMode = .scaleAspectFill
        seasonTitleLabel.textColor = .white
        seasonTitleLabel.font = .boldSystemFont(ofSize: 16)
        seasonOverviewLabel.textColor = .lightGray
        seasonOverviewLabel.font = .systemFont(ofSize: 13)
        seasonOverviewLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        seasonBackDropImageView.image = nil
    }
    
}
