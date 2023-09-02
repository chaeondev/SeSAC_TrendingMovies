//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/29.
//

import UIKit

protocol PassDataDelegate: AnyObject {
    func receiveData(text: String, row: IndexPath)
}

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    let settingList = ["Name", "Username", "Pronouns", "Bio", "Links", "Gender"]
    
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
        cell.titleLabel.text = settingList[indexPath.row]
        
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ["Name", "Username", "Bio"].contains(settingList[indexPath.row]) {
            let vc = EditViewController()
            vc.delegate = self
            vc.row = indexPath
            vc.typeLabel.text = settingList[indexPath.row]
            vc.textField.placeholder = "Add your \(settingList[indexPath.row])"
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}


extension ProfileViewController: PassDataDelegate {
    func receiveData(text: String, row: IndexPath) {
        detail = text
        print(detail)
        guard let selectedCell = mainView.tableView.cellForRow(at: row) as? SettingTableViewCell else { return }
        print(selectedCell)
        selectedCell.detailLabel.text = detail 
        
        mainView.tableView.reloadData()
    }
}
