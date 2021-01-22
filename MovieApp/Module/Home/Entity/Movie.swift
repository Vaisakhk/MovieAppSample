//
//  Movie.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import Foundation

struct MovieList: Codable {
    let totalResults : String
    let response :String
    let result: [Movie]

    enum CodingKeys: String, CodingKey {
        case totalResults = "totalResults"
        case response = "Response"
        case result = "Search"
    }
}


// MARK: - Result
struct Movie: Codable {
    let title, year, imdbID,type,poster: String
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
