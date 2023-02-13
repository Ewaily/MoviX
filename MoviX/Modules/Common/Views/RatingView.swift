//
//  RatingView.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 13/02/2023.
//

import UIKit

class RatingView: UIView {
    // MARK: UI Private Configurations

    private let maximumRating = 10
    
    // MARK: UI Public Configurations

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 3.2
        return stack
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func configureWithRating(rating: Int) {
        if rating > 0 {
            for _ in 1...rating {
                let image = generateStarView(.filled)
                stackView.addArrangedSubview(image)
            }
        }
        
        let nonFilledCount = maximumRating - rating
        if nonFilledCount > 0 {
            for _ in 1...nonFilledCount {
                let image = generateStarView(.nonFilled)
                stackView.addArrangedSubview(image)
            }
        }
    }
    
    private func generateStarView(_ type: StarType) -> UIImageView {
        let starImage: UIImage
        switch type {
        case .filled:
            starImage = UIImage(named: Images.FILLED_STAR)!
        case .nonFilled:
            starImage = UIImage(named: Images.UNFILLED_STAR)!
        }
        let image = UIImageView(image: starImage)
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: 21.4).isActive = true
        return image
    }
    
    enum StarType {
        case filled
        case nonFilled
    }
}
