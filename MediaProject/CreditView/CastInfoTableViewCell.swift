//
//  CastInfoTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit

class CastInfoTableViewCell: BaseTableViewCell {
    
    let personImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let realNameLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .black
        return view
    }()
    
    let roleNameLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .gray
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(personImageView)
        contentView.addSubview(realNameLabel)
        contentView.addSubview(roleNameLabel)
    }
    
    override func setConstraints() {
        
        personImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(12)
            make.height.equalTo(self.personImageView.snp.width).multipliedBy(1.5)
        }
        
        realNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(personImageView.snp.trailing).offset(32)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.greaterThanOrEqualTo(100)
        }
        
        roleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(realNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(personImageView.snp.trailing).offset(32)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.greaterThanOrEqualTo(100)
        }
        
    }
}
