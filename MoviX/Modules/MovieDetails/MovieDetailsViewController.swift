//
//  MovieDetailsViewController.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import UIKit

class MovieDetailsViewController: MoviesBaseViewController {
    // MARK: - Public properties -
    
    var presenter: MovieDetailsPresenterProtocol!
    
    // MARK: - Private properties -

    private lazy var blankView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.BACKGROUND_COLOR
        view.frame = self.view.frame
        return view
    }()
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratingView: RatingView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var overViewContainerView: UIView!
    @IBOutlet private weak var overViewTitleLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackButton()
        setupViews()
        presenter.viewDidLoad()
    }
    
    private func setupViews() {
        self.view.addSubview(blankView)
        overViewContainerView.layer.cornerRadius = 11.0
        setFonts()
        setViewsColors()
    }
    
    private func setViewsColors() {
        movieNameLabel.textColor = .white
        releaseDateLabel.textColor = .lightGray
        overViewTitleLabel.textColor = .white
        overViewLabel.textColor = .white
        overViewContainerView.backgroundColor = Colors.MOVIE_CELL_BACKGROUND
    }
    
    private func setFonts() {
        movieNameLabel.font = .boldSystemFont(ofSize: 30)
        releaseDateLabel.font = .systemFont(ofSize: 14)
        overViewTitleLabel.font = .boldSystemFont(ofSize: 16)
        overViewLabel.font = .systemFont(ofSize: 16)
    }
    
    private func setPosterImage(urlPath: String) {
        DispatchQueue.main.async {
            guard let url = URL(string: urlPath) else {
                self.posterImageView.image = UIImage(named: Images.PLACEHOLDER)
                return
            }
            self.posterImageView.load(url: url)
        }
    }
}

// MARK: - Extensions -

extension MovieDetailsViewController: MovieDetailsPresenterResponseDelegate {
    func showErrorAlert() {
        self.showGeneralErrorAlert()
    }
    
    func loadMovieDetailsView(model: MovieDetailsScreenModel) {
        DispatchQueue.main.async {
            self.overViewTitleLabel.text = Strings.OVERVIEW
            self.setPosterImage(urlPath: model.posterURL)
            self.movieNameLabel.text = model.originalTitle
            self.ratingView.configureWithRating(rating: Int(model.userRating))
            self.releaseDateLabel.text = model.releaseDate
            self.overViewLabel.text = model.overview
            self.blankView.removeFromSuperview()
        }
    }
}
