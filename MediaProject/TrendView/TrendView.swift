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
        let view = UISegmentedControl()
        view.setTitle("Movie", forSegmentAt: 0)
        view.setTitle("TV", forSegmentAt: 1)
        return view
    }()
    let periodButton = {
        let view = UIButton()
        view.setTitle("Day", for: .normal)
        view.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 11)
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
        
    }
    
    override func setConstraints() {
        
    }
    
    
}
