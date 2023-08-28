//
//  CreditView.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit
import SnapKit

class CreditView: BaseView {
    
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let blackView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        return view
    }()
    
    let movieTitleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = .white
        return view
    }()
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.register(StoryTableViewCell.self, forCellReuseIdentifier: StoryTableViewCell.identifier)
        view.register(CastInfoTableViewCell.self, forCellReuseIdentifier: CastInfoTableViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        
        addSubview(backdropImageView)
        addSubview(blackView)
        addSubview(posterImageView)
        addSubview(movieTitleLabel)
        addSubview(tableView)
        
    }
    
    override func setConstraints() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        blackView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(backdropImageView.snp.bottom)
            make.width.equalTo(backdropImageView.snp.width).multipliedBy(0.25)
            make.height.equalTo(self.posterImageView.snp.width).multipliedBy(1.4)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(posterImageView.snp.top).offset(-8)
            make.height.greaterThanOrEqualTo(backdropImageView.snp.height).multipliedBy(0.16)
            make.width.greaterThanOrEqualTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(backdropImageView.snp.bottom)
        }
        
    }
    
    
}
