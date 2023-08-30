//
//  ProfileView.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let topView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let editButton = {
        let view = UIButton()
        view.setTitle("Edit picture", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 12)
        return view
    }()
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        addSubview(topView)
        topView.addSubview(profileImage)
        topView.addSubview(editButton)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(self.profileImage.snp.height)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}
