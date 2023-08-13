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
    
    func callRequest(type: Endpoint, time: time_window = .day, movie_id: Int = 0, completionHandler: @escaping (JSON) -> ()) {
        
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
    
    func callExtraRequest(completionHandler: @escaping (JSON) -> ()) {
        let url = "https://api.themoviedb.org/3/genre/movie/list"
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
}


