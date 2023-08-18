//
//  CreditViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/14.
//

import UIKit
import Alamofire
import Kingfisher



class CreditViewController: UIViewController, DownBtnClicked {
    
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var backDropImageView: UIImageView!
    @IBOutlet var blackView: UIView!
    
    
    var castList: [PersonCredit] = []
    var movieInfo: Movie?
    var expand: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        
        let nib2 = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: CastTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        configureView()
        callRequest()
        
    }
    
    func callRequest() {
        let header: HTTPHeaders = [
            "Authorization" : APIKey.tmdbKey,
            "accept" : "application/json"
        ]
        let url = RequestURL(type: .credit, movie_id: movieInfo!.id).requestURL
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: Credit.self ) { response in
            guard let value = response.value else { return }
            for person in value.cast {
                let realName = person.name
                guard let castName = person.character,
                      let profilePath = person.profilePath else { return }
                let data = PersonCredit(realName: realName, castName: castName, profilePath: profilePath)
                self.castList.append(data)
                self.tableView.reloadData()
            }
        }
    }
    
    func configureView() {
        guard let movieInfo else { return }
        
        movieTitleLabel.text = movieInfo.title
        movieTitleLabel.font = .boldSystemFont(ofSize: 18)
        movieTitleLabel.textColor = .white
        
        if let posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + movieInfo.poster) {
            posterImageView.kf.setImage(with: posterUrl)
        }
        
        if let backUrl = URL(string: "https://image.tmdb.org/t/p/original" + movieInfo.backdrop) {
            backDropImageView.kf.setImage(with: backUrl)
        }
        backDropImageView.contentMode = .scaleAspectFill
        
        blackView.backgroundColor = .black.withAlphaComponent(0.6)
        
    }

}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Overview" : "Cast"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell()}
            cell.overviewLabel.text = movieInfo?.overview
            cell.myDelegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell()}
            cell.realNameLabel.text = castList[indexPath.row].realName
            cell.roleNameLabel.text = castList[indexPath.row].castName
            cell.personImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + castList[indexPath.row].profilePath))
            return cell
        }
        
    
    }
    
    func onDownBtnClicked() {
        tableView.reloadData()
    }
    
}
