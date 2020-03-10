//
//  AppCoordinatorTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces
import Resolver

class AppCoordinatorTests: XCTestCase {
    
    private var detailView: MockedDetailView?
    
    override func setUp() {
        super.setUp()
        Resolver.registerAllServices()
        
        // Defaults for testing
        Resolver.register { MockedFilterTypePicker() as AbstractFilterTypePicker }
        Resolver.register { MockedSortingTypePicker() as AbstractSortingTypePicker }
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedSuccessfulPlacesService() as AbstractPlacesService }
        
    }
    
    func testPassesSelectedPlaceToDetailView() {
        self.detailView = MockedDetailView()
        Resolver.register {
            self.detailView! as AbstractDetailView
        }
        Resolver.register {
            MockedDetailPresenter() as AbstractDetailPresenter
        }
        
        let place = MockedSuccessfulPlacesService().places.first!
        let coordinator = AppCoordinator()
        coordinator.mainViewSelected(place)
        
        XCTAssertEqual(detailView!.place?.id, place.id)
        XCTAssertEqual(detailView!.place?.name, place.name)
    }
    
    func testSortingFlow() {
        
        let sortingTypePicker = MockedSortingTypePicker()
        Resolver.register { sortingTypePicker as AbstractSortingTypePicker }
        
        let placesService = MockedSuccessfulPlacesService()
        Resolver.register { placesService as AbstractPlacesService }
        
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedAppCoordinator() as AbstractAppCoordinator }
        
        let appCoordinator: AbstractAppCoordinator = Resolver.resolve()
        let mockedCoordinator = appCoordinator as! MockedAppCoordinator
        
        XCTAssertFalse(mockedCoordinator.mainViewSelectSortingCalled)
        XCTAssertFalse(mockedCoordinator.mainViewSelectSortingCallbackCalled)
        appCoordinator.mainPresenter.userTappedSortingButton()
        XCTAssertTrue(mockedCoordinator.mainViewSelectSortingCalled)
        XCTAssertFalse(mockedCoordinator.mainViewSelectSortingCallbackCalled)
        sortingTypePicker.select(.closed)
        XCTAssertTrue(mockedCoordinator.mainViewSelectSortingCalled)
        XCTAssertTrue(mockedCoordinator.mainViewSelectSortingCallbackCalled)
    }
    
    func testFilteringFlow() {
        let filterTypePicker = MockedFilterTypePicker()
        Resolver.register { filterTypePicker as AbstractFilterTypePicker }
        
        let placesService = MockedSuccessfulPlacesService()
        Resolver.register { placesService as AbstractPlacesService }
        
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { MockedAppCoordinator() as AbstractAppCoordinator }
        
        let appCoordinator: AbstractAppCoordinator = Resolver.resolve()
        let mockedCoordinator = appCoordinator as! MockedAppCoordinator
        
        XCTAssertFalse(mockedCoordinator.mainViewSelectFiltersCalled)
        XCTAssertFalse(mockedCoordinator.mainViewSelectFiltersCallbackCalled)
        appCoordinator.mainPresenter.userTappedFilterButton()
        XCTAssertTrue(mockedCoordinator.mainViewSelectFiltersCalled)
        XCTAssertFalse(mockedCoordinator.mainViewSelectFiltersCallbackCalled)
        filterTypePicker.select([.closed])
        XCTAssertTrue(mockedCoordinator.mainViewSelectFiltersCalled)
        XCTAssertTrue(mockedCoordinator.mainViewSelectFiltersCallbackCalled)
    }
    
}
