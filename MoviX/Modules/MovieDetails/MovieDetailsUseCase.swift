//
//  MovieDetailsUseCase.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

protocol MovieDetailsUseCaseProtocol {
    func getMovieDetails(movieId: Int)
}

protocol MovieDetailsUseCaseResponseDelegate: AnyObject {
    func getMovieDetailsSuccess(movie: Movie)
    func getMovieDetailsFailed(error: NetworkError)
}

class MovieDetailsUseCase {
    // MARK: - Private properties -

    // MARK: - Public properties -

    var repository: MoviesRepositoryProtocol?
    weak var delegate: MovieDetailsUseCaseResponseDelegate?

    // MARK: - Init -

    init(repository: MoviesRepositoryProtocol? = nil, delegate: MovieDetailsUseCaseResponseDelegate? = nil) {
        if repository != nil {
            self.repository = repository!
        } else {
            self.repository = MoviesRepository(delegate: self)
        }

        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    func getMovieDetails(movieId: Int) {
        repository?.getMovieDetails(movieId: movieId)
    }
}

extension MovieDetailsUseCase: MoviesRepositoryResponseDelegate {
    func getMovieDetailsSuccess(jsonResponse: String) {
        let responseData = Data(jsonResponse.utf8)
        let successResult = responseData.decode(class: Movie.self)

        switch successResult {
        case .success(let movieResult):
            delegate?.getMovieDetailsSuccess(movie: movieResult)

        case .failure:
            delegate?.getMovieDetailsFailed(error: NetworkError.decodingError)
        }
    }

    func getMovieDetailsFailed(error: NetworkError) {
        delegate?.getMovieDetailsFailed(error: error)
    }
}
