//
//  MockedAppCoordinator.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedAppCoordinator: AppCoordinator {
    
    var mainViewSelectedCalled: Bool = false
    var mainViewSelectFiltersCalled: Bool = false
    var mainViewSelectFiltersCallbackCalled: Bool = false
    var mainViewSelectSortingCalled: Bool = false
    var mainViewSelectSortingCallbackCalled: Bool = false
    
    override func mainViewSelected(_ place: AbstractPlace) {
        super.mainViewSelected(place)
        mainViewSelectedCalled = true
    }
    
    override func mainViewSelectFilters(with currentFilters: [FilterType]?, _ callback: @escaping (([FilterType])-> Void)) {
        super.mainViewSelectFilters(with: currentFilters) { (value) in
            self.mainViewSelectFiltersCallbackCalled = true
            callback(value)
        }
        mainViewSelectFiltersCalled = true
    }
    
    override func mainViewSelectSorting(with currentSorting: SortingType?, _ callback: @escaping ((SortingType)-> Void)) {
        super.mainViewSelectSorting(with: currentSorting) { (value) in
            self.mainViewSelectSortingCallbackCalled = true
            callback(value)
        }
        mainViewSelectSortingCalled = true
    }
    
}
