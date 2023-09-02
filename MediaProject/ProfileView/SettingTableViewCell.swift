//
//  SettingTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/29.
//

import UIKit
import Kingfisher

class SettingTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 14, weight: .semibold)
        return view
    }()
    
    let detailLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    let arrowImage = {
        let view = UIImageView()
        view.tintColor = .lightGray
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(arrowImage)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(12)
            make.width.equalTo(80)
        }
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.verticalEdges.equalToSuperview().inset(8)
            make.width.greaterThanOrEqualTo(50)
        }
        arrowImage.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalToSuperview().inset(15)
            make.width.equalTo(15)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailLabel.text = ""
    }
    
}


