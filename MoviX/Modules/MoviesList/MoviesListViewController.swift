//
//  MoviesListViewController.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import UIKit

class MoviesListViewController: MoviesBaseViewController {
    // MARK: - Public properties -
    
    var presenter: MoviesListPresenterProtocol!
    
    // MARK: - Private properties -
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMoviesCollectionView()
        setupRefreshControl()
        self.addFilterBarButton(#selector(openFilter))
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
          flowLayout.invalidateLayout()
    }
    
    private func setupMoviesCollectionView() {
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(UINib(nibName: NibNames.MOVIESLISTCOLLECTIONVIEWCELL.rawValue, bundle: nil), forCellWithReuseIdentifier: NibNames.MOVIESLISTCOLLECTIONVIEWCELL.rawValue)
        moviesCollectionView.alwaysBounceVertical = true
        moviesCollectionView.refreshControl = refreshControl
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc
    private func openFilter() {
        let actionSheetController = UIAlertController(title: Strings.FILTER_MOVIES, message: nil, preferredStyle: .actionSheet)
        
        let firstAction = UIAlertAction(title: Strings.MOST_POPULAR, style: .default) { _ -> Void in
            
            self.presenter.getPopularMovies(forceRefresh: false)
        }
        
        let secondAction = UIAlertAction(title: Strings.TOP_RATED, style: .default) { _ -> Void in
            
            self.presenter.getTopRatedMovies(forceRefresh: false)
        }
        
        let cancelAction = UIAlertAction(title: Strings.CANCEL, style: .cancel) { _ -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        actionSheetController.popoverPresentationController?.sourceView = self.view
        
        present(actionSheetController, animated: true)
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        presenter.didPullToRefresh()
    }
}

// MARK: - Extensions -

extension MoviesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRow(index: indexPath.row)
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getSectionRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NibNames.MOVIESLISTCOLLECTIONVIEWCELL.rawValue,
            for: indexPath
        ) as? MovieCollectionViewCell {
            cell.setupCell(presenter.getMoviesListTableViewCellModel(index: indexPath.row))
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let itemWidth = screenWidth * (UIWindow.isLandscape ? 0.4 : 0.44)
        let itemHeight = itemWidth * 1.9
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
}

extension MoviesListViewController: MoviesListPresenterResponseDelegate {
    func showErrorAlert() {
        self.showGeneralErrorAlert()
    }
    
    func loadMoviesView() {
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func navigateToMovieDetailsScreen(movieId: Int) {
        let viewController = MovieDetailsViewController(nibName: Storyboards.MOVIESDETAILSVIEWCONTROLLER.rawValue, bundle: nil)
        let presenter = MovieDetailsPresenter(delegate: viewController, movieId: movieId)
        viewController.presenter = presenter
        if let navigator = navigationController {
            navigator.pushViewController(viewController, animated: true)
        }
    }
}
