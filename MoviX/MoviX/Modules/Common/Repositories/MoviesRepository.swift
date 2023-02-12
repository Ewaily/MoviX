//
//  MoviesRepository.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getTopRatedMovies()
    func getPopularMovies()
    func getMovieDetails(movieId: Int)
}

protocol MoviesRepositoryResponseDelegate: AnyObject {
    func getTopRatedMoviesSuccess(jsonResponse: String)
    func getTopRatedMoviesFailed(error: NetworkError)
    func getPopularMoviesSuccess(jsonResponse: String)
    func getPopularMoviesFailed(error: NetworkError)
    func getMovieDetailsSuccess(jsonResponse: String)
    func getMovieDetailsFailed(error: NetworkError)
}

extension MoviesRepositoryResponseDelegate {
    func getTopRatedMoviesSuccess(jsonResponse: String) {}
    func getTopRatedMoviesFailed(error: NetworkError) {}
    func getPopularMoviesSuccess(jsonResponse: String) {}
    func getPopularMoviesFailed(error: NetworkError) {}
    func getMovieDetailsSuccess(jsonResponse: String) {}
    func getMovieDetailsFailed(error: NetworkError) {}
}

class MoviesRepository {
    // MARK: - Public properties -
    
    weak var delegate: MoviesRepositoryResponseDelegate?
    var networkManager = NetworkManager.sharedInstance
    
    // MARK: - Init -
    
    init(delegate: MoviesRepositoryResponseDelegate? = nil) {
        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MoviesRepository: MoviesRepositoryProtocol {
    func getTopRatedMovies() {
        networkManager.request(requestModel: MoviesRequests.listTopRatedMovies) { [weak self] (result: Swift.Result<String, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let moviesJSON):
                self.delegate?.getTopRatedMoviesSuccess(jsonResponse: moviesJSON)
                
            case .failure(let error):
                self.delegate?.getTopRatedMoviesFailed(error: error)
            }
        }
    }
    
    
    func getPopularMovies() {
        networkManager.request(requestModel: MoviesRequests.listPopularMovies) { [weak self] (result: Swift.Result<String, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let moviesJSON):
                self.delegate?.getPopularMoviesSuccess(jsonResponse: moviesJSON)
                
            case .failure(let error):
                self.delegate?.getPopularMoviesFailed(error: error)
            }
        }
    }
    
    func getMovieDetails(movieId: Int) {
        networkManager.request(requestModel: MoviesRequests.movieDetails(movieId: movieId)) { [weak self] (result: Swift.Result<String, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetailsJSON):
                self.delegate?.getMovieDetailsSuccess(jsonResponse: movieDetailsJSON)
                
            case .failure(let error):
                self.delegate?.getMovieDetailsFailed(error: error)
            }
        }
    }
}
