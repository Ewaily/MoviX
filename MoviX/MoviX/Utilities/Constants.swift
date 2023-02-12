//
//  Constants.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 12/02/2023.
//

import Foundation

enum Storyboards : String {
    case MOVIESDETAILSVIEWCONTROLLER = "MovieDetailsViewController"
}

enum NibNames : String {
    case MOVIESLISTTABLEVIEWCELL = "MoviesListTableViewCell"
}

struct Strings {
    static let MOVIES_LIST = "Movies List"
    static let ERROR = "Error"
    static let FAILED_TO_GET_YOUR_RESPONSE = "Failed to get your response!"
    static let TRY_AGAIN = "Try again"
    static let CANCEL = "Cancel"
}

struct EndPoints {
    static let LIST_TOP_RATED_MOVIES = "https://api.themoviedb.org/3/movie/top_rated"
    static let LIST_POPULAR_MOVIES = "https://api.themoviedb.org/3/movie/popular"
    static let MOVIE_DETAILS = "https://api.themoviedb.org/3/movie/"
}

struct ParamterKeys {
    static let API_KEY = "api_key"
}

struct NetworkConstants {
    static let API_KEY_VALUE = "941c80911e56e1882c3f3dd744b6bb0b"
    static let IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/w500"
}

struct Images {
    static let PLACEHOLDER = "img_placeholder"
}
