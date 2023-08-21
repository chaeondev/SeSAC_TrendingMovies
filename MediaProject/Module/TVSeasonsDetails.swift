//
//  TVSeasonsDetails.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/18.
//

import Foundation

// MARK: - TVSeasonsDetails
struct TVSeasonsDetails: Codable {
    let id: String
    let episodes: [Episode]
    let name, overview: String
    let tvSeasonsDetailsID: Int
    let posterPath, airDate: String?
    let seasonNumber: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case tvSeasonsDetailsID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String?
    let episodeNumber: Int
    let episodeType: String
    let id: Int
    let name, overview, productionCode: String
    let seasonNumber, showID: Int
    let runtime: Int?
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

