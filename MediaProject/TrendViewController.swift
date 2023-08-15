//
//  ViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/11.
//

import UIKit
import Kingfisher

class TrendViewController: UIViewController {

    @IBOutlet var trendTableView: UITableView!
    
    var movieList: [Movie] = []
    var origingenres: [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: ContentTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: ContentTableViewCell.identifier)
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        
        trendTableView.rowHeight = 450
        
        TMDBAPIManager.shared.callExtraRequest { json in
            
            for item in json["genres"].arrayValue {
                let id = item["id"].intValue
                let name = item["name"].stringValue
                
                self.origingenres.updateValue(name, forKey: id)
            }
        }
        
        TMDBAPIManager.shared.callRequest(type: .trend, time: .day) { json in
            for item in json["results"].arrayValue {
                let id = item["id"].intValue
                let title = item["title"].stringValue
                let date = item["release_date"].stringValue
                var genres: [String] = []
                for genre in item["genre_ids"].arrayValue{
                    if let genreName = self.origingenres[genre.intValue] {
                        genres.append(genreName)
                    }
                }
                let poster = item["poster_path"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                let overview = item["overview"].stringValue

                let data = Movie(id: id, title: title, releaseDate: date, genre: genres, poster: poster, backdrop: backdrop, overview: overview)
                self.movieList.append(data)

            }
            // MARK: reload 어느 시점에?
            self.trendTableView.reloadData()
        }
        
        
        
        
    }

}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as? ContentTableViewCell else { return UITableViewCell()}
        
        cell.titleLabel.text = movieList[indexPath.row].title
        cell.dateLabel.text = movieList[indexPath.row].releaseDate
        if let url = URL(string: "https://image.tmdb.org/t/p/original" + movieList[indexPath.row].backdrop) {
            cell.backdropImageView.kf.setImage(with: url)
        }
        cell.storyLabel.text = movieList[indexPath.row].overview
        cell.genreLabel.text = movieList[indexPath.row].genre.map{ "#\($0)" }.joined(separator: ", ")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionView(rowIndex: indexPath.row)
    }
    
    func transitionView(rowIndex: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: CreditViewController.identifier) as? CreditViewController else { return }
        vc.movieInfo = movieList[rowIndex]
        navigationController?.pushViewController(vc, animated: true)
    }
}
