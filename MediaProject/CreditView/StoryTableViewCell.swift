//
//  StoryTableViewCell.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit

class StoryTableViewCell: BaseTableViewCell {
    
    let overviewLabel = {
        let view = UILabel()
        view.textColor = .black
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let downButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    var expand: Bool = false
    var myDelegate : DownBtnClicked?
    
    
    
    override func configureView() {
        
        contentView.addSubview(overviewLabel)
        contentView.addSubview(downButton)
        
        downButton.addTarget(self, action: #selector(downButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() {
    
        overviewLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(16)
        }
        
        downButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(overviewLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    @objc func downButtonClicked() {
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
