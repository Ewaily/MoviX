//
//  MoviesRequests.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

enum MoviesRequests: RequestModel {
    case listTopRatedMovies
    case listPopularMovies
    case movieDetails(movieId: Int)

    var method: RequestMethod {
        switch self {
        case .listTopRatedMovies:
            return .get
            
        case .listPopularMovies:
            return .get
            
        case .movieDetails:
            return .get
        }
    }

    var path: String {
        switch self {
        case .listTopRatedMovies:
            return EndPoints.LIST_TOP_RATED_MOVIES
            
        case .listPopularMovies:
            return EndPoints.LIST_POPULAR_MOVIES
            
        case .movieDetails(let movieId):
            return "\(EndPoints.MOVIE_DETAILS)/\(movieId)"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .listTopRatedMovies:
            return nil
            
        case .listPopularMovies:
            return nil
            
        case .movieDetails:
            return nil
        }
    }

    var paramters: [String: Any]? {
        switch self {
        case .listTopRatedMovies:
            return [ParamterKeys.API_KEY: NetworkConstants.API_KEY_VALUE]
            
        case .listPopularMovies:
            return [ParamterKeys.API_KEY: NetworkConstants.API_KEY_VALUE]
            
        case .movieDetails:
            return [ParamterKeys.API_KEY: NetworkConstants.API_KEY_VALUE]
        }
    }

    var requestBodyParemeters: [String: Any]? {
        switch self {
        case .listTopRatedMovies:
            return nil
            
        case .listPopularMovies:
            return nil
            
        case .movieDetails:
            return nil
        }
    }
}
