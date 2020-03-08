//
//  MainScreenTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces
@testable import Resolver

class MainScreenTests: XCTestCase {
    
    var selectedPlace: AbstractPlace?
    var selectedFilters: [FilterType]?
    var selectedSorting: SortingType?
    var sortingTypePicker: MockedSortingTypePicker?
    var filterTypePicker: MockedFilterTypePicker?
    
    override func setUp() {
        super.setUp()
        Resolver.registerAllServices()
    }
    
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
    
    func testCorrectSortingIsApplied() {
        self.sortingTypePicker = MockedSortingTypePicker()
        Resolver.register { self.sortingTypePicker! as AbstractSortingTypePicker}
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        presenter.set(delegate: self)
        
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.open)
        XCTAssertEqual(presenter.getSorting(), .open)
        
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.closed)
        XCTAssertEqual(presenter.getSorting(), .closed)
        
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.distanceHigher)
        XCTAssertEqual(presenter.getSorting(), .distanceHigher)
        
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.distanceLower)
        XCTAssertEqual(presenter.getSorting(), .distanceLower)
        
    }
    
    func testCorrectFilterIsApplied() {
        self.filterTypePicker = MockedFilterTypePicker()
        Resolver.register { self.filterTypePicker! as AbstractFilterTypePicker}
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        presenter.set(delegate: self)
        presenter.userTappedFilterButton()
        filterTypePicker?.select([.closed, .withRating])
        XCTAssertEqual(presenter.getFilters(), [.closed, .withRating])
        
        presenter.userTappedFilterButton()
        filterTypePicker?.select([.open])
        XCTAssertEqual(presenter.getFilters(), [.open])
        
        presenter.userTappedFilterButton()
        filterTypePicker?.select([])
        XCTAssertEqual(presenter.getFilters(), [])
    }
    
    func testPullToRefresh() {
        Resolver.register { MockedMainPresenter() as AbstractMainPresenter }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        presenter.view.pullToRefresh()
        let mockedPresenter = presenter as! MockedMainPresenter
        
        XCTAssertEqual(mockedPresenter.refreshPlacesListCalled, true)
    }
    
    func testDelegateGetsNotifiedOfPlaceSelection() {
        let placesService = MockedSuccessfulPlacesService()
        Resolver.register { MockedMainPresenter() as AbstractMainPresenter }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { placesService as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        let place = placesService.places.first! as AbstractPlace
        presenter.set(delegate: self)
        presenter.userSelected(place: place)
        
        XCTAssertEqual(selectedPlace?.id, place.id)
    }
}

// MARK: - AbstractMainViewDelegate
extension MainScreenTests: AbstractMainViewDelegate {

    func mainViewSelected(_ place: AbstractPlace) {
        selectedPlace = place
    }

    func mainViewSelectFilters(with currentFilters: [FilterType]?, _ callback: @escaping (([FilterType])-> Void)) {
        self.filterTypePicker?.callback = { (type) in
            callback(type)
        }
        self.filterTypePicker?.selectedValues = Set<FilterType>(currentFilters ?? [])
    }
    
    func mainViewSelectSorting(with currentSorting: SortingType?, _ callback: @escaping ((SortingType)-> Void)) {
        self.sortingTypePicker?.callback = { (type) in
            callback(type)
        }
        self.sortingTypePicker?.selectedValue = currentSorting
        
    }

}

fileprivate class MockedMainPresenter: MainPresenter {
    
    var refreshPlacesListCalled: Bool = false
    override func refreshPlacesList() {
        refreshPlacesListCalled = true
    }
    
}


fileprivate class MockedMainView: AbstractMainView {
    
    var presenter: AbstractMainPresenter?
    var places: [AbstractPlace]?
    var errorMessage: String?
    var showingLoadingIndicator: Bool?
    var viewIsLoaded: Bool = false
    var pulledToRefresh: Bool = false
    var delegate: AbstractMainViewDelegate?
    
    func show(places: [AbstractPlace]) {
        self.places = places
    }
    
    func pullToRefresh() {
        pulledToRefresh = true
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
