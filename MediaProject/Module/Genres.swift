//
//  TVGenre.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/08/18.
//

import Foundation

// MARK: - TVGenre
struct TVGenre: Codable {
    let genres: [Genre]
}

// MARK: - MovieGenre
struct MovieGenre: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
