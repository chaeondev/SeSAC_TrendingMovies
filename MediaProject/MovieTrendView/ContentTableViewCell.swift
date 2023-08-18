//
//  ContentTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/11.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    
    
    @IBOutlet var shadowView: UIView!

    @IBOutlet var backView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var storyLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designView()
        designLabel()
        designImageView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func designView() {
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.clipsToBounds = false
        
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true

        
        
    }
    
    func designLabel() {
        dateLabel.font = .systemFont(ofSize: 11)
        dateLabel.textColor = .gray
        
        genreLabel.font = .boldSystemFont(ofSize: 14)
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        storyLabel.font = .systemFont(ofSize: 13, weight: .regular)
        storyLabel.numberOfLines = 2
        storyLabel.textColor = .darkGray
    }
    
    func designImageView() {
        backdropImageView.contentMode = .scaleAspectFill
    }
}
