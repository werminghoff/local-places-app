//
//  MockedDetailView.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedDetailView: DetailViewController {
    
    var place: AbstractPlace?
    var errorMessage: String?
    var showReviewsLoadingIndicatorCalled: Bool = false
    var showPhotoLoadingIndicatorCalled: Bool = false
    var hideReviewsLoadingIndicatorCalled: Bool = false
    var hidePhotoLoadingIndicatorCalled: Bool = false
    
    override func show(place: AbstractPlace) {
        self.place = place
        super.show(place: place)
    }
    
    override func show(errorMessage: String) {
        super.show(errorMessage: errorMessage)
        self.errorMessage = errorMessage
    }
    
    override func showReviewsLoadingIndicator() {
        super.showReviewsLoadingIndicator()
        showReviewsLoadingIndicatorCalled = true
    }
    
    override func showPhotoLoadingIndicator() {
        super.showPhotoLoadingIndicator()
        showPhotoLoadingIndicatorCalled = true
    }
    
    override func hideReviewsLoadingIndicator() {
        super.hideReviewsLoadingIndicator()
        hideReviewsLoadingIndicatorCalled = true
    }
    
    override func hidePhotoLoadingIndicator() {
        super.hidePhotoLoadingIndicator()
        hidePhotoLoadingIndicatorCalled = true
    }
}
