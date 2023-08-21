//
//  EpisodeCollectionViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/18.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var epiPosterImageView: UIImageView!
    @IBOutlet var epiTitleLabel: UILabel!
    @IBOutlet var blackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        epiPosterImageView.contentMode = .scaleAspectFill
        epiTitleLabel.textColor = .white
        epiTitleLabel.font = .boldSystemFont(ofSize: 13)
        epiTitleLabel.numberOfLines = 0
        blackView.backgroundColor = .black.withAlphaComponent(0.4)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        epiPosterImageView.image = nil
    }

    
}
