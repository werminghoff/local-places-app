//
//  DetailPresenter.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

class DetailPresenter: AbstractDetailPresenter {
    
    @Injected var view: AbstractDetailView
    @Injected var placesService: AbstractPlacesService
    
    func set(place: AbstractPlace) {
        view.show(place: place)
        view.showReviewsLoadingIndicator()
        placesService.fetchReviews(for: place) { [weak self] (reviews, error) in
            guard let self = self else { return }
            
            self.view.hideReviewsLoadingIndicator()
            if let error = error {
                self.view.show(errorMessage: error)
            } else {
                self.view.show(reviews: reviews ?? [])
            }
        }
        
        view.showPhotoLoadingIndicator()
        placesService.fetchPhoto(for: place) { [weak self] (image, error) in
            guard let self = self else { return }
            self.view.hidePhotoLoadingIndicator()
            if let error = error {
                self.view.show(errorMessage: error)
            } else {
                self.view.show(photo: image)
            }
        }
        
    }
}
