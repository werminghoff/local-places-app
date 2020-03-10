//
//  MainPresenterTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces
@testable import Resolver

class MainPresenterTests: XCTestCase {
    
    var selectedPlace: AbstractPlace?
    var selectedFilters: [FilterType]?
    var selectedSorting: SortingType?
    var sortingTypePicker: MockedSortingTypePicker?
    var filterTypePicker: MockedFilterTypePicker?
    
    override func setUp() {
        super.setUp()
        Resolver.registerAllServices()
    }
    
    override func tearDown() {
        super.tearDown()
        selectedPlace = nil
        selectedFilters = nil
        selectedSorting = nil
        sortingTypePicker = nil
        filterTypePicker = nil
    }
    
    /**
     - Given: Main screen is loading, and something prevents the app to get the user's location
     - When: Main screen tries to get the user's location
     - Then: Main view receives the error message to show
     */
    func testViewShowsLocationError() {
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedFailableLocationService(fetchError: "Failed to get user location") as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        XCTAssert(presenter.view is MockedMainView)
        let view = presenter.view as! MockedMainView
        XCTAssertEqual(view.errorMessage, "Failed to get user location")
        
    }
    
    /**
    - Given: Main screen is loading, and something prevents the app to fetch nearby places
    - When: Main screen tries to fetch nearby places
    - Then: Main view receives the error message to show
    */
    func testViewShowsPlacesListError() {
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedFailablePlacesService(fetchNearError: "Failed to fetch places", fetchNearPhoto: nil, fetchNearReviews: nil) as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        
        XCTAssert(presenter.view is MockedMainView)
        let view = presenter.view as! MockedMainView
        XCTAssertEqual(view.errorMessage, "Failed to fetch places")
    }
    
    /**
    - Given: Main screen is loading, user location and nearby places are available
    - When: Main screen finishes loading
    - Then: Main view receives the correct places to display
    */
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
    
    /**
    - Given: Main screen is loaded
    - When: User selects a sorting method
    - Then: Main view receives the sorted list of places, with correct sorting
    */
    func testCorrectSortingIsApplied() {
        self.sortingTypePicker = MockedSortingTypePicker()
        Resolver.register { self.sortingTypePicker! as AbstractSortingTypePicker}
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        let view = presenter.view as! MockedMainView
        presenter.set(delegate: self)
        
        XCTAssertEqual(view.places?.count, 4)
        
        // Sort by Open now
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.open)
        XCTAssertEqual(view.places![0].isOpenNow, true)
        XCTAssertEqual(view.places![1].isOpenNow, true)
        XCTAssertEqual(view.places![2].isOpenNow, nil)
        XCTAssertEqual(view.places![3].isOpenNow, false)
        
        // Sort by Closed now
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.closed)
        XCTAssertEqual(view.places![0].isOpenNow, false)
        XCTAssertEqual(view.places![1].isOpenNow, nil)
        XCTAssertEqual(view.places![2].isOpenNow, true)
        XCTAssertEqual(view.places![3].isOpenNow, true)
        
        // Sort by higher distance
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.distanceHigher)
        XCTAssertEqual(view.places![0].distance.rounded(), (333.117).rounded())
        XCTAssertEqual(view.places![1].distance.rounded(), (332.442).rounded())
        XCTAssertEqual(view.places![2].distance.rounded(), (327.657).rounded())
        XCTAssertEqual(view.places![3].distance.rounded(), (187.515).rounded())
        
        // Sort by lower distance
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.distanceLower)
        XCTAssertEqual(view.places![0].distance.rounded(), (187.515).rounded())
        XCTAssertEqual(view.places![1].distance.rounded(), (327.657).rounded())
        XCTAssertEqual(view.places![2].distance.rounded(), (332.442).rounded())
        XCTAssertEqual(view.places![3].distance.rounded(), (333.117).rounded())
        
        // Sort by name ascending
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.nameAscending)
        XCTAssertEqual(view.places![0].name, "Place 1")
        XCTAssertEqual(view.places![1].name, "Place 2")
        XCTAssertEqual(view.places![2].name, "Place 3")
        XCTAssertEqual(view.places![3].name, "Place 4 with amazingly long name for whatever reason")
        
        // Sort by name descending
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.nameDescending)
        XCTAssertEqual(view.places![0].name, "Place 4 with amazingly long name for whatever reason")
        XCTAssertEqual(view.places![1].name, "Place 3")
        XCTAssertEqual(view.places![2].name, "Place 2")
        XCTAssertEqual(view.places![3].name, "Place 1")
        
        // Sort by higher rating
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.ratingHigher)
        XCTAssertEqual(view.places![0].rating, 4.8)
        XCTAssertEqual(view.places![1].rating, 4.1)
        XCTAssertEqual(view.places![2].rating, 2.2)
        XCTAssertEqual(view.places![3].rating, nil)
        
        // Sort by lower rating
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.ratingLower)
        XCTAssertEqual(view.places![0].rating, 2.2)
        XCTAssertEqual(view.places![1].rating, 4.1)
        XCTAssertEqual(view.places![2].rating, 4.8)
        XCTAssertEqual(view.places![3].rating, nil)
    }
    
    /**
    - Given: Main screen is loaded
    - When: User selects a filter method
    - Then: Main view receives the sorted list of places, with correct sorting
    */
    func testCorrectFilterIsApplied() {
        self.filterTypePicker = MockedFilterTypePicker()
        self.sortingTypePicker = MockedSortingTypePicker()
        Resolver.register { self.filterTypePicker! as AbstractFilterTypePicker }
        Resolver.register { self.sortingTypePicker! as AbstractSortingTypePicker }
        Resolver.register { MockedMainView() as AbstractMainView }
        Resolver.register { MockedMainPresenter() as AbstractMainPresenter }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }

        let presenter: AbstractMainPresenter = Resolver.resolve()
        let view = presenter.view as! MockedMainView
        presenter.set(delegate: self)
        
        // Set the sorting method
        presenter.userTappedSortingButton()
        sortingTypePicker?.select(.nameAscending)
        
        // Filter by closed now
        presenter.userTappedFilterButton()
        filterTypePicker?.select([.closed])
        XCTAssertEqual(view.places?.count, 1)
        XCTAssertEqual(view.places?[0].name, "Place 3")
        
        // Filter by open now
        presenter.userTappedFilterButton()
        filterTypePicker?.select([.open])
        XCTAssertEqual(view.places?.count, 2)
        XCTAssertEqual(view.places?[0].name, "Place 2")
        XCTAssertEqual(view.places?[1].name, "Place 4 with amazingly long name for whatever reason")
        
        // Filter by unknown rating
        presenter.userTappedFilterButton()
        filterTypePicker?.select([.withoutRating])
        XCTAssertEqual(view.places?.count, 1)
        XCTAssertEqual(view.places?[0].name, "Place 1")
        
        // Filter by known rating
        presenter.userTappedFilterButton()
        filterTypePicker?.select([.withRating])
        XCTAssertEqual(view.places?.count, 3)
        XCTAssertEqual(view.places?[0].name, "Place 2")
        XCTAssertEqual(view.places?[1].name, "Place 3")
        XCTAssertEqual(view.places?[2].name, "Place 4 with amazingly long name for whatever reason")
    }
    
    /**
    - Given: Main screen is loaded
    - When: User performs a pull-to-refresh swipe movement
    - Then: Presenter is notified of the event
    */
    func testPullToRefresh() {
        let placesService = MockedSuccessfulPlacesService()
        let view = MockedMainView()

        Resolver.register { view as AbstractMainView }
        Resolver.register { MockedMainPresenter() as AbstractMainPresenter }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { placesService as AbstractPlacesService }
        
        let presenter: AbstractMainPresenter = Resolver.resolve()
        let mockedPresenter = presenter as! MockedMainPresenter
        
        // Initial load
        XCTAssertEqual(view.places?.count, 4)
        XCTAssertEqual(view.places?[0].name, "Place 3")
        XCTAssertEqual(view.places?[1].name, "Place 2")
        XCTAssertEqual(view.places?[2].name, "Place 4 with amazingly long name for whatever reason")
        XCTAssertEqual(view.places?[3].name, "Place 1")
        XCTAssertEqual(mockedPresenter.refreshPlacesListCalled, false)
        
        // Replace the places in our PlacesService as if the user moved to another place
        placesService.places = [
            MockedSuccessfulPlacesService.MockedPlaceModel(id: "place_new",
                                                           name: "New place",
                                                           coordinate: Coordinate(latitude: 0.0, longitude: 0.0),
                                                           isOpenNow: true,
                                                           rating: 5.0,
                                                           photoIdentifier: nil,
                                                           distance: 100,
                                                           formattedDistance: "100m")
        ]
        
        view.pullToRefresh()
        XCTAssertEqual(mockedPresenter.refreshPlacesListCalled, true)
        XCTAssertEqual(view.places?.count, 1)
        XCTAssertEqual(view.places?[0].name, "New place")
    }
    
    /**
    - Given: Main screen is loaded
    - When: User selects one of the places listed on the app
    - Then: Main view's delegate receives the selected place
    */
    func testDelegateReceivesUserSelectedPlace() {
        let placesService = MockedSuccessfulPlacesService()
        let view = MockedMainView()
        let presenter = MockedMainPresenter()
        Resolver.register { view as AbstractMainView }
        Resolver.register { presenter as AbstractMainPresenter }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { placesService as AbstractPlacesService }
        
        let place = placesService.places.first! as AbstractPlace
        presenter.set(delegate: self)
        presenter.userSelected(place: place)
        
        XCTAssertEqual(selectedPlace?.id, place.id)
    }
}

// MARK: - AbstractMainViewDelegate
extension MainPresenterTests: AbstractMainViewDelegate {

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
        super.refreshPlacesList()
    }
    
}


fileprivate class MockedMainView: MainViewController {
    
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
