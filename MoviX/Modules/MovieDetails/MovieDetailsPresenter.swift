//
//  MovieDetailsPresenter.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

protocol MovieDetailsPresenterProtocol {
    func viewDidLoad()
}

protocol MovieDetailsPresenterResponseDelegate: AnyObject {
    func showLoading(_ show: Bool)
    func showErrorAlert()
    func loadMovieDetailsView(model: MovieDetailsScreenModel)
    func setNavigationItemTitle(_ title: String)
}

class MovieDetailsPresenter {
    // MARK: - Public properties -

    var useCase: MovieDetailsUseCaseProtocol?
    weak var delegate: MovieDetailsPresenterResponseDelegate?

    // MARK: - Private properties -

    private var currentMovieId: Int = 0

    // MARK: - Init -

    init(useCase: MovieDetailsUseCaseProtocol? = nil, delegate: MovieDetailsPresenterResponseDelegate? = nil, movieId: Int) {
        if useCase != nil {
            self.useCase = useCase!
        } else {
            self.useCase = MovieDetailsUseCase(delegate: self)
        }

        self.delegate = delegate
        self.currentMovieId = movieId
    }
}

// MARK: - Extensions -

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func viewDidLoad() {
        delegate?.showLoading(true)
        useCase?.getMovieDetails(movieId: currentMovieId)
    }
}

extension MovieDetailsPresenter: MovieDetailsUseCaseResponseDelegate {
    func getMovieDetailsSuccess(movie: Movie) {
        delegate?.showLoading(false)
        let model = MovieDetailsScreenModel(originalTitle: movie.originalTitle, posterURL: "\(NetworkConstants.IMAGE_BASE_PATH)\(movie.posterPath)", overview: movie.overview, userRating: movie.voteAverage, releaseDate: movie.releaseDate)
        delegate?.setNavigationItemTitle(movie.title ?? movie.originalTitle)
        delegate?.loadMovieDetailsView(model: model)
    }

    func getMovieDetailsFailed(error: NetworkError) {
        delegate?.showLoading(false)
        delegate?.showErrorAlert()
    }
}
