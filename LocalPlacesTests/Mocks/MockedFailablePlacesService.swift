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
    var fetchNearPhoto: String?
    var fetchNearReviews: String?
    
    internal init(fetchNearError: String?, fetchNearPhoto: String?, fetchNearReviews: String?) {
        self.fetchNearError = fetchNearError
        self.fetchNearPhoto = fetchNearPhoto
        self.fetchNearReviews = fetchNearReviews
    }
    
    override func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?) {
        if let fetchNearError = fetchNearError {
            callback?(nil, fetchNearError)
        } else {
            super.fetchNear(coordinate: coordinate, callback: callback)
        }
    }
    
    override func fetchPhoto(for place: AbstractPlace, callback: FetchPhotoCallback?) {
        if let fetchNearPhoto = fetchNearPhoto {
            callback?(nil, fetchNearPhoto)
        } else {
            super.fetchPhoto(for: place, callback: callback)
        }
    }
    
    override func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        if let fetchNearReviews = fetchNearReviews {
            callback?(nil, fetchNearReviews)
        } else {
            super.fetchReviews(for: place, callback: callback)
        }
    }
}
