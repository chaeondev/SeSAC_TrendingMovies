//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/29.
//

import UIKit

protocol PassDataDelegate: AnyObject {
    func receiveData(text: String, index: IndexPath)
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    var settingList = SettingList().list
    
    var detail = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureView() {
        super.configureView()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = settingList[indexPath.row].title
        if settingList[indexPath.row].detail.isEmpty {
            cell.detailLabel.text = settingList[indexPath.row].title
            cell.detailLabel.textColor = .lightGray
        } else {
            cell.detailLabel.text = settingList[indexPath.row].detail
            cell.detailLabel.textColor = .black
        }
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settingList[indexPath.row].title == "Gender" {
            let vc = GenderViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = EditViewController()
            vc.delegate = self
            vc.index = indexPath
            vc.typeLabel.text = settingList[indexPath.row].title
            vc.textField.placeholder = "Add your \(settingList[indexPath.row].title)"
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}


extension ProfileViewController: PassDataDelegate {
    func receiveData(text: String, index: IndexPath) {
        settingList[index.row].detail = text
        mainView.tableView.reloadRows(at: [index], with: .automatic)
    }
}
