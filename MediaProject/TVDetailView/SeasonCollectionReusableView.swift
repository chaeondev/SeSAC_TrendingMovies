//
//  SeasonCollectionReusableView.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit

class SeasonCollectionReusableView: BaseCollectionReusableView {
    
    let seasonBackdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let seasonTitleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let seasonOverviewLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 13)
        view.numberOfLines = 0
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        seasonBackdropImageView.image = nil
    }
    
    override func configureView() {
        self.backgroundColor = .black.withAlphaComponent(0.6)
        
        addSubview(seasonBackdropImageView)
        addSubview(seasonTitleLabel)
        addSubview(seasonOverviewLabel)
    }
    
    override func setConstraints() {
        
        seasonBackdropImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(12)
            make.height.equalTo(self.seasonBackdropImageView.snp.width).multipliedBy(1.5)
        }
        seasonTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(seasonBackdropImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(12)
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }
        seasonOverviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(seasonBackdropImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(seasonTitleLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        
    }
    
    
    
    
    
    
}
