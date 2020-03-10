//
//  MockedMainView.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedMainView: MainViewController {
    
    var places: [AbstractPlace]?
    var errorMessage: String?
    var showingLoadingIndicator: Bool?
    var viewIsLoaded: Bool = false
    var pulledToRefresh: Bool = false
    
    override func show(places: [AbstractPlace]) {
        super.show(places: places)
        self.places = places
    }
    
    override func pullToRefresh() {
        super.pullToRefresh()
        pulledToRefresh = true
    }
    
    override func show(errorMessage: String) {
        super.show(errorMessage: errorMessage)
        self.errorMessage = errorMessage
    }
    
    override func showLoadingIndicator() {
        super.showLoadingIndicator()
        self.showingLoadingIndicator = true
    }
    
    override func hideLoadingIndicator() {
        super.hideLoadingIndicator()
        self.showingLoadingIndicator = false
    }
    
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        viewIsLoaded = true
    }
    
    
}

