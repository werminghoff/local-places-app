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
        callback(Coordinate(latitude: 1.0, longitude: 1.0), nil)
    }
    
}
