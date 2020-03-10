//
//  DetailPresenterTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces
@testable import Resolver

class DetailPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Resolver.registerAllServices()
        
        // Defaults for testing
        Resolver.register { MockedFilterTypePicker() as AbstractFilterTypePicker }
        Resolver.register { MockedSortingTypePicker() as AbstractSortingTypePicker }
        Resolver.register { MockedDetailView() as AbstractDetailView }
        Resolver.register { MockedDetailPresenter() as AbstractDetailPresenter }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
    - Given: Detail screen loaded, and something prevents it from fetching the users' reviews
    - When: Detail screen tries to load the users' reviews
    - Then: Detail view receives the error message to show
    */
    func testViewShowsFetchReviewError() {
        Resolver.register { MockedFailablePlacesService(fetchNearError: nil, fetchPhotoError: nil, fetchReviewsError: "Error while fetching reviews") as AbstractPlacesService }
        
        let placesService: AbstractPlacesService = Resolver.resolve()
        let mockedPlacesService = placesService as! MockedSuccessfulPlacesService
        
        let presenter: AbstractDetailPresenter = Resolver.resolve()
        let mockedPresenter = presenter as! MockedDetailPresenter
        
        let view = presenter.view as! MockedDetailView
        
        mockedPresenter.set(place: mockedPlacesService.places.first!)
        XCTAssertEqual(view.errorMessage, "Error while fetching reviews")
    }
    
    /**
    - Given: Detail screen loaded, and something prevents it from fetching the place's photo
    - When: Detail screen tries to load the place's photo
    - Then: Detail view receives the error message to show
    */
    func testViewShowsFetchPhotoError() {
        Resolver.register { MockedFailablePlacesService(fetchNearError: nil, fetchPhotoError: "Error while fetching photo", fetchReviewsError: nil) as AbstractPlacesService }
        
        let placesService: AbstractPlacesService = Resolver.resolve()
        let mockedPlacesService = placesService as! MockedSuccessfulPlacesService
        
        let presenter: AbstractDetailPresenter = Resolver.resolve()
        let mockedPresenter = presenter as! MockedDetailPresenter
        
        let view = presenter.view as! MockedDetailView
        
        mockedPresenter.set(place: mockedPlacesService.places.first!)
        XCTAssertEqual(view.errorMessage, "Error while fetching photo")
    }
    
    /**
    - Given: Detail screen loaded normally
    - When: Detail finished loading
    - Then: Detail screen shows loading indicators while loading and hides them after finishing
    */
    func testViewShowsActivityIndicators() {
        
        let placesService: AbstractPlacesService = Resolver.resolve()
        let mockedPlacesService = placesService as! MockedSuccessfulPlacesService
        
        let presenter: AbstractDetailPresenter = Resolver.resolve()
        let mockedPresenter = presenter as! MockedDetailPresenter
        
        let view = presenter.view as! MockedDetailView
        
        mockedPresenter.set(place: mockedPlacesService.places.first!)
        
        XCTAssertEqual(view.showReviewsLoadingIndicatorCalled, true)
        XCTAssertEqual(view.showPhotoLoadingIndicatorCalled, true)
        XCTAssertEqual(view.hideReviewsLoadingIndicatorCalled, true)
        XCTAssertEqual(view.hidePhotoLoadingIndicatorCalled, true)
    }
    
}

