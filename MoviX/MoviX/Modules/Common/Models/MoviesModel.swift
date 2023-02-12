//
//  MoviesModel.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
}

// MARK: - Result
struct Result: Codable {
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case it = "it"
    case ko = "ko"
}
