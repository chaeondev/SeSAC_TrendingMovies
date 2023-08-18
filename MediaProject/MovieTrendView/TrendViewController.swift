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
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var movieList: [Movie] = []
    var movieGenres: [Int : String] = [:]
    
    var tvList: TVTrend = TVTrend(page: 0, results: [], totalPages: 0, totalResults: 0)
    var tvGenres: [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: ContentTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: ContentTableViewCell.identifier)
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        
        trendTableView.rowHeight = 450
        
        TMDBAPIManager.shared.callMovieListRequest { data in
            for genre in data.genres {
                let id = genre.id
                let name = genre.name
                self.movieGenres.updateValue(name, forKey: id)
            }
        }
        
        TMDBAPIManager.shared.callMovieRequest(type: .trend, time: .day) { json in
            for item in json["results"].arrayValue {
                let id = item["id"].intValue
                let title = item["title"].stringValue
                let date = item["release_date"].stringValue
                var genres: [String] = []
                for genre in item["genre_ids"].arrayValue{
                    if let genreName = self.movieGenres[genre.intValue] {
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
        
        TMDBAPIManager.shared.callTVListRequest { data in
            for genre in data.genres {
                self.tvGenres.updateValue(genre.name, forKey: genre.id)
            }
        }
        
        TMDBAPIManager.shared.callTVRequest { data in
            self.tvList = data
            self.trendTableView.reloadData()
        }
        
        
        
    }
    
    
    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0, 1:
            trendTableView.reloadData()
        default:
            print("error")
        }
    }
    
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return movieList.count
        case 1:
            return tvList.results.count
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier) as? ContentTableViewCell else { return UITableViewCell()}
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.titleLabel.text = movieList[indexPath.row].title
            cell.dateLabel.text = movieList[indexPath.row].releaseDate
            if let url = URL(string: "https://image.tmdb.org/t/p/original" + movieList[indexPath.row].backdrop) {
                cell.backdropImageView.kf.setImage(with: url)
            }
            cell.storyLabel.text = movieList[indexPath.row].overview
            cell.genreLabel.text = movieList[indexPath.row].genre.map{ "#\($0)" }.joined(separator: ", ")
            return cell
        case 1:
            cell.titleLabel.text = tvList.results[indexPath.row].name
            cell.dateLabel.text = tvList.results[indexPath.row].firstAirDate
            if let url = URL(string: "https://image.tmdb.org/t/p/original" + tvList.results[indexPath.row].backdropPath) {
                cell.backdropImageView.kf.setImage(with: url)
            }
            cell.storyLabel.text = tvList.results[indexPath.row].overview
            var genres: [String] = []
            for genre in tvList.results[indexPath.row].genreIDS {
                genres.append(tvGenres[genre]!)
            }
            cell.genreLabel.text = genres.map{ "#\($0)" }.joined(separator: ", ")
            
            return cell
        default:
            return UITableViewCell()
        }
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
