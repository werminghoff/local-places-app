//
//  PlaceTableViewCell.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    let ratingLabel = UILabel.autoLayout()
    let nameLabel = UILabel.autoLayout()
    let openImageView = UIImageView.autoLayout()
    
    var place: AbstractPlace? {
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
        contentView.addSubview(ratingLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(openImageView)
        
        nameLabel.font = .preferredFont(forTextStyle: .body)
        nameLabel.textColor = .titleColor
        nameLabel.numberOfLines = 0 // allow multi-line names
        
        ratingLabel.font = .preferredFont(forTextStyle: .caption1)
        ratingLabel.textColor = .subtitleColor
    }
    
    private func setupConstraints() {
        let views = [
            "ratingLabel": ratingLabel,
            "nameLabel": nameLabel,
            "openImageView": openImageView
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[nameLabel]-[openImageView]-16-|", metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nameLabel]-[ratingLabel]-|", metrics: nil, views: views))
        
        contentView.addConstraints([
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            openImageView.widthAnchor.constraint(equalToConstant: 40),
            openImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            openImageView.widthAnchor.constraint(equalTo: openImageView.heightAnchor)
        ])
    }
  
    private func updateCell() {
        guard let place = place else {
            ratingLabel.text = ""
            nameLabel.text = ""
            openImageView.image = nil
            openImageView.accessibilityLabel = ""
            return
        }
        
        if let rating = place.rating {
            ratingLabel.text = String(format: "Rating: %01.1lf", rating)
        } else {
            ratingLabel.text = "Rating unavailable"
        }
        
        nameLabel.text = "\(place.name) (\(place.formattedDistance))"
        
        if place.isOpenNow == true {
            openImageView.image = #imageLiteral(resourceName: "icon_open")
            openImageView.accessibilityLabel = Accessibility.statusOpen
        } else if place.isOpenNow == false {
            openImageView.image = #imageLiteral(resourceName: "icon_closed")
            openImageView.accessibilityLabel = Accessibility.statusClosed
        } else {
            openImageView.accessibilityLabel = ""
            openImageView.image = nil
        }
        
    }
    
}
