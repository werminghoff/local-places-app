//
//  DetailViewController.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, AbstractDetailView {
    
    var presenter: AbstractDetailPresenter?
    
    private var photoNotAvailableLabel = UILabel.autoLayout()
    private var photoImageView = UIImageView.autoLayout()
    private var emptyStateLabel = UILabel.autoLayout()
    private var nameLabel = UILabel.autoLayout()
    private var dividerView = UIView.autoLayout()
    private var ratingLabel = UILabel.autoLayout()
    private var openImageView = UIImageView.autoLayout()
    private var reviewsActivityIndicator = UIActivityIndicatorView.autoLayout()
    private var photoActivityIndicator = UIActivityIndicatorView.autoLayout()
    private var tableView = UITableView.autoLayout()
    private var reviews: [AbstractReview] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        photoImageView.accessibilityIdentifier = Accessibility.detailPhoto.identifier
        
        photoNotAvailableLabel.accessibilityIdentifier = Accessibility.errorLoadingPhotoLabel.identifier
        emptyStateLabel.accessibilityIdentifier = Accessibility.errorLoadingReviewsLabel.identifier
        
        ratingLabel.accessibilityIdentifier = Accessibility.detailRating.identifier
        openImageView.accessibilityIdentifier = Accessibility.detailOpen.identifier
        nameLabel.accessibilityIdentifier = Accessibility.detailName.identifier
        
        view.addSubview(dividerView)
        view.addSubview(photoImageView)
        view.addSubview(emptyStateLabel)
        view.addSubview(nameLabel)
        view.addSubview(ratingLabel)
        view.addSubview(openImageView)
        view.addSubview(photoActivityIndicator)
        view.addSubview(photoNotAvailableLabel)
        
        view.addSubview(tableView)
        view.addSubview(reviewsActivityIndicator)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = nil
        tableView.register(ReviewTableViewCell.self)
        tableView.allowsSelection = false
        
        nameLabel.font = .preferredFont(forTextStyle: .body)
        nameLabel.textColor = .titleColor
        nameLabel.numberOfLines = 0
        
        dividerView.backgroundColor = .separatorColor
        
        photoNotAvailableLabel.font = .preferredFont(forTextStyle: .body)
        photoNotAvailableLabel.textColor = .subtitleColor
        photoNotAvailableLabel.numberOfLines = 0
        photoNotAvailableLabel.isHidden = true
        photoNotAvailableLabel.text = "Photo not available for this place"
        
        emptyStateLabel.font = .preferredFont(forTextStyle: .body)
        emptyStateLabel.textColor = .subtitleColor
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.isHidden = true
        emptyStateLabel.text = "There are no reviews for this place"
        
        ratingLabel.font = .preferredFont(forTextStyle: .caption1)
        ratingLabel.textColor = .subtitleColor
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        let views = [
            "nameLabel": nameLabel,
            "ratingLabel": ratingLabel,
            "dividerView": dividerView,
            "openImageView": openImageView,
            "photoImageView": photoImageView,
            "photoNotAvailableLabel": photoNotAvailableLabel,
            "emptyStateLabel": emptyStateLabel,
            "activityIndicator": reviewsActivityIndicator,
            "tableView": tableView
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[photoImageView]-16-[nameLabel]-8-[ratingLabel]-16-[dividerView(0.3)][tableView]|", metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[nameLabel]-16-[openImageView]-16-|", metrics: nil, views: views))
        
        view.addConstraints([
            
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
            photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            dividerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            openImageView.widthAnchor.constraint(equalToConstant: 40),
            openImageView.heightAnchor.constraint(equalTo: openImageView.widthAnchor),
            openImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        view.addConstraints([
            reviewsActivityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            reviewsActivityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            
            photoActivityIndicator.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            photoActivityIndicator.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            
            photoNotAvailableLabel.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            photoNotAvailableLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            photoNotAvailableLabel.widthAnchor.constraint(equalTo: photoImageView.widthAnchor, multiplier: 0.75),
            photoNotAvailableLabel.heightAnchor.constraint(lessThanOrEqualTo: photoImageView.heightAnchor),
            
            emptyStateLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            emptyStateLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.75)
        ])
    }
    
    func show(place: AbstractPlace) {
        nameLabel.text = "\(place.name) (\(place.formattedDistance))"
        
        if let rating = place.rating {
            ratingLabel.text = String(format: "Average rating: %01.1lf", rating)
        } else {
            ratingLabel.text = "Average rating unavailable"
        }
        
        if place.isOpenNow == true {
            openImageView.image = #imageLiteral(resourceName: "icon_open")
            openImageView.accessibilityValue = Accessibility.statusOpen
        } else if place.isOpenNow == false {
            openImageView.image = #imageLiteral(resourceName: "icon_closed")
            openImageView.accessibilityValue = Accessibility.statusClosed
        } else {
            openImageView.accessibilityValue = Accessibility.statusNone
            openImageView.image = nil
        }
        
    }
    
    func show(photo: UIImage?) {
        if let photo = photo {
            photoImageView.accessibilityValue = Accessibility.statusPhotoLoaded
            photoImageView.isHidden = false
            photoImageView.image = photo
            photoNotAvailableLabel.isHidden = true
        } else {
            photoImageView.accessibilityValue = Accessibility.statusNone
            photoImageView.isHidden = true
            photoImageView.image = nil
            photoNotAvailableLabel.isHidden = false
        }
        photoActivityIndicator.stopAnimating()
    }
    
    func show(reviews: [AbstractReview]) {
        self.reviews = reviews
        reviewsActivityIndicator.stopAnimating()
        
        tableView.isHidden = (self.reviews.count == 0)
        emptyStateLabel.isHidden = !(tableView.isHidden)
        
        tableView.reloadData()
    }
    
    func showReviewsLoadingIndicator() {
        tableView.isHidden = true
        emptyStateLabel.isHidden = true
        reviewsActivityIndicator.startAnimating()
    }
    
    func showPhotoLoadingIndicator() {
        photoImageView.isHidden = true
        photoActivityIndicator.startAnimating()
    }
    
    func hideReviewsLoadingIndicator() {
        reviewsActivityIndicator.stopAnimating()
    }
    
    func hidePhotoLoadingIndicator() {
        photoActivityIndicator.stopAnimating()
    }
    
    func show(errorMessage: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ReviewTableViewCell.self, for: indexPath)
        let row = indexPath.row
        cell.review = reviews[row]
        cell.usernameLabel.accessibilityIdentifier = Accessibility.reviewName(row).identifier
        cell.reviewLabel.accessibilityIdentifier = Accessibility.reviewText(row).identifier
        cell.ratingLabel.accessibilityIdentifier = Accessibility.reviewRating(row).identifier
        return cell
    }
}
