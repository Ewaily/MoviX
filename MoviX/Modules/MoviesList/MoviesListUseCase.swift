//
//  MoviesListUseCase.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

protocol MoviesListUseCaseProtocol {
    func getTopRatedMovies()
    func getPopularMovies()
}

protocol MoviesListUseCaseResponseDelegate: AnyObject {
    func getTopRatedMoviesSuccess(movies: Movies)
    func getTopRatedMoviesFailed(error: NetworkError)
    func getPopularMoviesSuccess(movies: Movies)
    func getPopularMoviesFailed(error: NetworkError)
}

class MoviesListUseCase {
    // MARK: - Private properties -

    // MARK: - Public properties -
    
    var repository: MoviesRepositoryProtocol?
    weak var delegate: MoviesListUseCaseResponseDelegate?
    
    // MARK: - Init -
    
    init(repository: MoviesRepositoryProtocol? = nil, delegate: MoviesListUseCaseResponseDelegate? = nil) {
        if repository != nil {
            self.repository = repository!
        } else {
            self.repository = MoviesRepository(delegate: self)
        }
        
        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MoviesListUseCase: MoviesListUseCaseProtocol {
    func getTopRatedMovies() {
        repository?.getTopRatedMovies()
    }
    
    func getPopularMovies() {
        repository?.getPopularMovies()
    }
}

extension MoviesListUseCase: MoviesRepositoryResponseDelegate {
    func getTopRatedMoviesSuccess(jsonResponse: String) {
        let responseData = Data(jsonResponse.utf8)
        let successResult = responseData.decode(class: Movies.self)
        
        switch successResult {
        case .success(let moviesResult):
            delegate?.getTopRatedMoviesSuccess(movies: moviesResult)
            
        case .failure:
            delegate?.getTopRatedMoviesFailed(error: NetworkError.decodingError)
        }
    }
    
    func getTopRatedMoviesFailed(error: NetworkError) {
        delegate?.getTopRatedMoviesFailed(error: error)
    }
    
    func getPopularMoviesSuccess(jsonResponse: String) {
        let responseData = Data(jsonResponse.utf8)
        let successResult = responseData.decode(class: Movies.self)
        
        switch successResult {
        case .success(let moviesResult):
            delegate?.getPopularMoviesSuccess(movies: moviesResult)
            
        case .failure:
            delegate?.getPopularMoviesFailed(error: NetworkError.decodingError)
        }
    }
    
    func getPopularMoviesFailed(error: NetworkError) {
        delegate?.getPopularMoviesFailed(error: error)
    }
}
