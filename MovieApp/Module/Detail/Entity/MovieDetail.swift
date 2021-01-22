//
//  MovieDetail.swift
//  MovieApp
//
//  Created by User on 1/22/21.
//

import Foundation

struct MovieDetail: Codable {
    let title,year : String
    let response,rated,released,runtime,genre,director,writer,actors,
        plot,language,country,awards,poster,metascore,imdbRating,imdbVotes,imdbID,
        type,dvd,boxOffice,production,website:String
    let ratings: [Ratings]

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case ratings = "Ratings"
    }
}


// MARK: - Result
struct Ratings: Codable {
    let source, value: String
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
