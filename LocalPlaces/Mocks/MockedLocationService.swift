//
//  MockedLocationService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

class MockedLocationService: AbstractLocationService {
    
    func fetch(_ callback: @escaping (Coordinate?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(Coordinate(latitude: -30.022834, longitude: -51.183083))
        }
        
    }
    
}
