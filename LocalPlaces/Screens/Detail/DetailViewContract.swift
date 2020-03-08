//
//  DetailViewContract.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import UIKit

protocol AbstractDetailView: class {
    var presenter: AbstractDetailPresenter? { get set }
    func loadViewIfNeeded()
    
    func show(place: AbstractPlace)
    func show(photo: UIImage?)
    func show(reviews: [AbstractReview])
    func show(errorMessage: String)
    
    func showReviewsLoadingIndicator()
    func showPhotoLoadingIndicator()
    
    func hideReviewsLoadingIndicator()
    func hidePhotoLoadingIndicator()
}

protocol AbstractDetailPresenter: class {
    var view: AbstractDetailView { get }
    func set(place: AbstractPlace)
}
