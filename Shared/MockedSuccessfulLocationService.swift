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
    
    private(set) var delay: Double?
    
    convenience init(delay: Double?) {
        self.init()
        self.delay = delay
    }
    
    func fetch(_ callback: @escaping LocationUpdatedCallback) {
        let coordinate = Coordinate(latitude: -30.021834, longitude: -51.183243)
        if let delay = delay {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                callback(coordinate, nil)
            }
        } else {
            callback(coordinate, nil)
        }
    }
    
}
