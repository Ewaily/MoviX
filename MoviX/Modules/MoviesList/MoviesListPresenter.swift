//
//  MoviesListPresenter.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import Foundation

protocol MoviesListPresenterProtocol {
    func viewDidLoad()
    func getTopRatedMovies(forceRefresh: Bool)
    func getPopularMovies(forceRefresh: Bool)
    func getSectionRows() -> Int
    func getMoviesListTableViewCellModel(index: Int) -> MovieCollectionViewCellModel
    func didSelectRow(index: Int)
    func didPullToRefresh()
}

protocol MoviesListPresenterResponseDelegate: AnyObject {
    func showLoading(_ show: Bool)
    func showErrorAlert()
    func loadMoviesView()
    func navigateToMovieDetailsScreen(movieId: Int)
    func setNavigationItemTitle(_ title: String)
}

class MoviesListPresenter {
    // MARK: - Public properties -

    var useCase: MoviesListUseCaseProtocol?
    weak var delegate: MoviesListPresenterResponseDelegate?
    enum ListingMode {
        case topRated
        case mostPopular
    }

    // MARK: - Private properties -

    private var moviesList: [Result]?
    private var currentListingMode: ListingMode = .mostPopular
    
    // MARK: - Init -

    init(useCase: MoviesListUseCaseProtocol? = nil, delegate: MoviesListPresenterResponseDelegate? = nil) {
        if useCase != nil {
            self.useCase = useCase!
        } else {
            self.useCase = MoviesListUseCase(delegate: self)
        }

        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MoviesListPresenter: MoviesListPresenterProtocol {
    func getTopRatedMovies(forceRefresh: Bool = false) {
        guard currentListingMode != .topRated || forceRefresh else { return }
        currentListingMode = .topRated
        delegate?.showLoading(true)
        useCase?.getTopRatedMovies()
    }
    
    func getPopularMovies(forceRefresh: Bool = false) {
        guard currentListingMode != .mostPopular || forceRefresh else { return }
        currentListingMode = .mostPopular
        delegate?.showLoading(true)
        useCase?.getPopularMovies()
    }
    
    func didSelectRow(index: Int) {
        guard let moviesList = moviesList, !moviesList.isEmpty else { return }
        delegate?.navigateToMovieDetailsScreen(movieId: moviesList[index].id)
    }
    
    func getMoviesListTableViewCellModel(index: Int) -> MovieCollectionViewCellModel {
        guard let moviesList = moviesList else { return .init(title: "", releaseDate: "", imageURL: "") }

        let model = MovieCollectionViewCellModel(title: moviesList[index].originalTitle, releaseDate: moviesList[index].releaseDate, imageURL: moviesList[index].posterPath)
        return model
    }
    
    func getSectionRows() -> Int {
        guard let moviesList = moviesList else { return 0 }
        return moviesList.count
    }
    
    func viewDidLoad() {
        delegate?.showLoading(true)
        useCase?.getPopularMovies()
    }
    
    func didPullToRefresh() {
        switch currentListingMode {
        case .mostPopular:
            getPopularMovies(forceRefresh: true)
            
        case .topRated:
            getTopRatedMovies(forceRefresh: true)
        }
    }
}

extension MoviesListPresenter: MoviesListUseCaseResponseDelegate {
    func getTopRatedMoviesSuccess(movies: Movies) {
        delegate?.showLoading(false)
        self.moviesList = movies.results
        delegate?.setNavigationItemTitle(Strings.TOP_RATED_MOVIES_LIST)
        delegate?.loadMoviesView()
    }
    
    func getTopRatedMoviesFailed(error: NetworkError) {
        delegate?.showLoading(false)
        delegate?.showErrorAlert()
    }
    
    func getPopularMoviesSuccess(movies: Movies) {
        delegate?.showLoading(false)
        self.moviesList = movies.results
        delegate?.setNavigationItemTitle(Strings.MOST_POPULAR_MOVIES_LIST)
        delegate?.loadMoviesView()
    }
    
    func getPopularMoviesFailed(error: NetworkError) {
        delegate?.showLoading(false)
        delegate?.showErrorAlert()
    }
}
