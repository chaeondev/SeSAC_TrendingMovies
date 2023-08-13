//
//  ViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: ContentTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: ContentTableViewCell.identifier)
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        
        TMDBAPIManager.shared.callRequest(type: .trend, time: .day) { json in
            print(json["results"])
        }
        
    }


}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as? ContentTableViewCell else { return UITableViewCell()}
        
        return cell
    }
    
    
}
