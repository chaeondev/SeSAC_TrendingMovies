//
//  MediaTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit

class MediaTableViewCell: BaseTableViewCell {
    
    let dateLabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 11)
        return view
    }()
    let genreLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 14)
        return view
    }()
    let shadowView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        view.clipsToBounds = false
        return view
    }()
    let contentBackgroundView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .black
        return view
    }()
    let storyLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.numberOfLines = 2
        view.textColor = .darkGray
        return view
    }()
    let lineView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func configureView() {
        addSubview(dateLabel)
        addSubview(genreLabel)
        addSubview(shadowView)
        addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(backdropImageView)
        contentBackgroundView.addSubview(titleLabel)
        contentBackgroundView.addSubview(storyLabel)
        contentBackgroundView.addSubview(lineView)
    }
    
    override func setConstraints() {
        
        dateLabel.snp.makeConstraints { make in
            make.topMargin.leadingMargin.equalToSuperview().inset(8)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalToSuperview().multipliedBy(0.04)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
            make.leadingMargin.equalToSuperview().inset(8)
            make.width.greaterThanOrEqualTo(70)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        shadowView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.width.equalTo(self.shadowView.snp.height).multipliedBy(1)
        }
        
        contentBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.width.equalTo(self.contentBackgroundView.snp.height).multipliedBy(1)
        }
        
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.equalToSuperview().inset(12)
            make.top.equalTo(backdropImageView.snp.bottom).offset(12)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        storyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        lineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.top.equalTo(storyLabel.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        
    }
    
    
    
}
