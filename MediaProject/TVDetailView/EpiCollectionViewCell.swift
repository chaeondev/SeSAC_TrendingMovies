//
//  EpiCollectionViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit

class EpiCollectionViewCell: BaseCollectionViewCell {
    
    let epiPosterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let blackView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    
    let epiTitleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 13)
        view.numberOfLines = 0
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        epiPosterImageView.image = nil
    }
    
    override func configureView() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        contentView.addSubview(epiPosterImageView)
        contentView.addSubview(blackView)
        contentView.addSubview(epiTitleLabel)
        
    }
    
    override func setConstraints() {
        
        epiPosterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        epiTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
    }
    
}
