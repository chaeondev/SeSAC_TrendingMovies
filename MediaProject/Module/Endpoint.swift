//
//  Endpoint.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/11.
//

import Foundation

enum Endpoint {
    case trend
    case credit
}

enum time_window: String {
    case day, week
}

struct RequestURL {
    var type: Endpoint
    var time: time_window
    var movie_id: Int
    
    var requestURL: String {
        switch type {
        case .trend:
            return URL.makeEndPointString("trending/movie/\(time.rawValue)")
        case .credit:
            return URL.makeEndPointString("movie/\(movie_id)/credits")
        }
    }
}
