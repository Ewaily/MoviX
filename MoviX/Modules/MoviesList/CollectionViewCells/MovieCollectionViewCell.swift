//
//  MovieCollectionViewCell.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    private var task: URLSessionDataTask?
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        moviePoster.image = UIImage(named: Images.PLACEHOLDER)
        task?.cancel()
    }
    
    func setupCell(_ model: MovieCollectionViewCellModel) {
        configurePosterImageViewWith(url: generateImageFullPath(shortPath: model.imageURL))
        movieName.text = model.title
        movieReleaseDate.text = model.releaseDate
    }
    
    private func generateImageFullPath(shortPath: String) -> String {
        return "\(NetworkConstants.IMAGE_BASE_PATH)\(shortPath)"
    }
    
    private func configurePosterImageViewWith(url string: String) {
        guard let url = URL(string: string) else { return }
        
        task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.moviePoster.image = image
                }
            }
        }
        task?.resume()
    }
    
    private func setupView() {
        containerView.layer.cornerRadius = 4.0
        containerView.backgroundColor = Colors.MOVIE_CELL_BACKGROUND
        movieName.textColor = .white
        movieReleaseDate.textColor = .lightGray
    }
}
