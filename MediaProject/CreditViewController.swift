//
//  CreditViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/14.
//

import UIKit
import Alamofire



class CreditViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var backDropImageView: UIImageView!
    
    var castList: [String] = []
    let movieid: Int = 0
    var result: Credit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        
        let nib2 = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: CastTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        callRequest()
    }
    
    func callRequest() {
        let header: HTTPHeaders = [
            "Authorization" : APIKey.tmdbKey,
            "accept" : "application/json"
        ]
        let url = "https://api.themoviedb.org/3/movie/569094/credits?language=en-US"
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Credit.self ) { response in
            guard let value = response.value else { return }
            print(value.cast)
        }
    }

}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell()}
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell()}
            return cell
        }
    
    }
    
    
}
