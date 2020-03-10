//
//  MockedFailablePlacesService.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedFailablePlacesService: MockedSuccessfulPlacesService {
    
    var fetchNearError: String?
    var fetchPhotoError: String?
    var fetchReviewsError: String?
    
    internal init(fetchNearError: String?, fetchPhotoError: String?, fetchReviewsError: String?) {
        self.fetchNearError = fetchNearError
        self.fetchPhotoError = fetchPhotoError
        self.fetchReviewsError = fetchReviewsError
    }
    
    override func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?) {
        if let fetchNearError = fetchNearError {
            callback?(nil, fetchNearError)
        } else {
            super.fetchNear(coordinate: coordinate, callback: callback)
        }
    }
    
    override func fetchPhoto(for place: AbstractPlace, callback: FetchPhotoCallback?) {
        if let fetchPhotoError = fetchPhotoError {
            callback?(nil, fetchPhotoError)
        } else {
            super.fetchPhoto(for: place, callback: callback)
        }
    }
    
    override func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        if let fetchReviewsError = fetchReviewsError {
            callback?(nil, fetchReviewsError)
        } else {
            super.fetchReviews(for: place, callback: callback)
        }
    }
}
