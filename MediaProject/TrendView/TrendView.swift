//
//  TrendView.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/28.
//

import UIKit

class TrendView: BaseView {
    
    let topView = {
        let view = UIView()
        return view
    }()
    let mediaSegmentedControl = {
        let view = UISegmentedControl(items: ["Movie", "TV"])
        view.selectedSegmentIndex = 0
        return view
    }()
    let periodButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        view.setTitle("Day", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 13)
        view.tintColor = .black
        return view
    }()
    let tableView = {
        let view = UITableView()
        view.rowHeight = 450
        view.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifier)
        return view
    }()
    
    
    
    override func configureView() {
        
        addSubview(topView)
        topView.addSubview(mediaSegmentedControl)
        topView.addSubview(periodButton)
        addSubview(tableView)
        
    }
    
    override func setConstraints() {
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        mediaSegmentedControl.snp.makeConstraints { make in
            make.leadingMargin.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        periodButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailingMargin.equalToSuperview().inset(12)
        }
        tableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(topView.snp.bottom)
        }
        
    }
    
    
}
