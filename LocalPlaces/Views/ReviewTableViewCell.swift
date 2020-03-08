//
//  ReviewTableViewCell.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    private let usernameLabel = UILabel.autoLayout()
    private let reviewLabel = UILabel.autoLayout()
    private let ratingLabel = UILabel.autoLayout()
    
    var review: AbstractReview? {
        didSet{
            updateCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(reviewLabel)
        contentView.addSubview(ratingLabel)
        
        usernameLabel.font = .preferredFont(forTextStyle: .body)
        usernameLabel.textColor = .titleColor
        usernameLabel.numberOfLines = 0 // allow multi-line names
        
        reviewLabel.font = .preferredFont(forTextStyle: .body)
        reviewLabel.textColor = .subtitleColor
        reviewLabel.numberOfLines = 0 // allow multi-line names
        
        ratingLabel.font = .preferredFont(forTextStyle: .caption1)
        ratingLabel.textColor = .subtitleColor
    }
    
    private func setupConstraints() {
        let views = [
            "usernameLabel": usernameLabel,
            "reviewLabel": reviewLabel,
            "ratingLabel": ratingLabel
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[usernameLabel]-8-[reviewLabel]-16-|", metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[usernameLabel]->=16-[ratingLabel]-16-|", metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[reviewLabel]-16-|", metrics: nil, views: views))
        
        contentView.addConstraints([
            ratingLabel.topAnchor.constraint(equalTo: usernameLabel.topAnchor)
        ])
    }
    
    private func updateCell() {
        
        usernameLabel.text = review?.username
        reviewLabel.text = review?.text
        
        if let rating = review?.rating {
            ratingLabel.text = String(format: "Rating: %01.1lf", rating)
        } else {
            ratingLabel.text = "Rating unavailable"
        }
        
    }
}
