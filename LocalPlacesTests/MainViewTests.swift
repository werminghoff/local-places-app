//
//  MainViewTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces
@testable import Resolver

class MainViewTests: XCTestCase {
    
    func testViewShowsLocationError() {
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedFailableLocationService(fetchError: "Failed to get user location") as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        XCTAssert(presenter.view is MockedMainView)
        let view = presenter.view as! MockedMainView
        XCTAssertEqual(view.errorMessage, "Failed to get user location")
        
    }
    
    func testViewShowsPlacesListError() {
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedFailablePlacesService(fetchNearError: "Failed to fetch places", fetchNearPhoto: nil, fetchNearReviews: nil) as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        XCTAssert(presenter.view is MockedMainView)
        let view = presenter.view as! MockedMainView
        XCTAssertEqual(view.errorMessage, "Failed to fetch places")
    }
    
    func testViewShowsCorrectNumberOfPlaces() {
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        XCTAssert(presenter.view is MockedMainView)
        let view = presenter.view as! MockedMainView
        XCTAssertEqual(view.errorMessage, nil)
        XCTAssertEqual(view.places?.count, 4)
        
    }
    
}


fileprivate class MockedMainView: AbstractMainView {
    
    var presenter: AbstractMainPresenter?
    var places: [AbstractPlace]?
    var errorMessage: String?
    var showingLoadingIndicator: Bool?
    var viewIsLoaded: Bool = false
    var delegate: AbstractMainViewDelegate?
    
    func show(places: [AbstractPlace]) {
        self.places = places
    }
    
    func show(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    func showLoadingIndicator() {
        self.showingLoadingIndicator = true
    }
    
    func hideLoadingIndicator() {
        self.showingLoadingIndicator = false
    }
    
    func set(delegate: AbstractMainViewDelegate?) {
        self.delegate = delegate
    }
    
    func loadViewIfNeeded() {
        viewIsLoaded = true
    }
    
    
}
