//
//  CreditViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/14.
//

import UIKit
import Alamofire
import Kingfisher



class CreditViewController: BaseViewController, DownBtnClicked {
    
    var castList: [PersonCredit] = []
    var movieInfo: Movie?
    var expand: Bool = false
    
    let mainView = CreditView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
    }
    
    override func configureView() {
        super.configureView()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        guard let movieInfo else { return }
        
        mainView.movieTitleLabel.text = movieInfo.title
        if let posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + movieInfo.poster) {
            mainView.posterImageView.kf.setImage(with: posterUrl)
        }
        if let backUrl = URL(string: "https://image.tmdb.org/t/p/original" + movieInfo.backdrop) {
            mainView.backdropImageView.kf.setImage(with: backUrl)
        }
    }
    
    override func setConstraints() { }
    
    
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
                self.mainView.tableView.reloadData()
            }
        }
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.identifier) as? StoryTableViewCell else { return UITableViewCell()}
            cell.overviewLabel.text = movieInfo?.overview
            cell.myDelegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastInfoTableViewCell.identifier) as? CastInfoTableViewCell else { return UITableViewCell()}
            cell.realNameLabel.text = castList[indexPath.row].realName
            cell.roleNameLabel.text = castList[indexPath.row].castName
            cell.personImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + castList[indexPath.row].profilePath))
            return cell
        }
        
    
    }
    
    func onDownBtnClicked() {
        mainView.tableView.reloadData()
    }
    
}
