//
//  MockedMainPresenter.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedMainPresenter: MainPresenter {
    
    var refreshPlacesListCalled: Bool = false
    override func refreshPlacesList() {
        refreshPlacesListCalled = true
        super.refreshPlacesList()
    }
    
}
