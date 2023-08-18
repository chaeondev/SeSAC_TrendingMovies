//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = [
        "Authorization" : APIKey.tmdbKey,
        "accept" : "application/json"
    ]
    
    func callMovieRequest(type: Endpoint, time: time_window = .day, movie_id: Int = 0, completionHandler: @escaping (JSON) -> ()) {
        
        let url = RequestURL(type: type, time: time, movie_id: movie_id).requestURL
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callMovieListRequest(completionHandler: @escaping (MovieGenre) -> ()) {
        let url = "https://api.themoviedb.org/3/genre/movie/list"
        AF.request(url, method: .get, headers: header).validate()
            .responseDecodable(of: MovieGenre.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    func callTVRequest(time: time_window = .day, completionHandler: @escaping (TVTrend) -> () ) {
        let url = "https://api.themoviedb.org/3/trending/tv/\(time)"
        AF.request(url, headers: header).validate()
            .responseDecodable(of: TVTrend.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func callTVListRequest(completionHandler: @escaping (TVGenre) -> () ) {
        let url = "https://api.themoviedb.org/3/genre/tv/list"
        AF.request(url, headers: header).validate()
            .responseDecodable(of: TVGenre.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

