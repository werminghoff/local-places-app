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
        
        let placesService = MockedSuccessfulPlacesService()
        Resolver.shared.reset()
        Resolver.registerAllServices()
        Resolver.register { MockedSuccessfulLocationService() as AbstractLocationService }
        Resolver.register { placesService as AbstractPlacesService }
        
        let appCoordinator = AppCoordinator()
        appCoordinator.mainViewSelected(placesService.places.first!)
    }
    
    func testFilteringFlow() {
    }
    
}
