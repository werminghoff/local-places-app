//
//  MockedSuccessfulLocationService.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedSuccessfulLocationService: AbstractLocationService {
    
    func fetch(_ callback: @escaping LocationUpdatedCallback) {
        callback(Coordinate(latitude: -30.021834, longitude: -51.183243), nil)
    }
    
}
