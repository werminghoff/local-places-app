//
//  MockedFailableLocationService.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedFailableLocationService: MockedSuccessfulLocationService {
    var fetchError: String?
    
    convenience init(delay: Double? = nil, fetchError: String?) {
        self.init(delay: delay)
        self.fetchError = fetchError
    }
    
    override func fetch(_ callback: @escaping LocationUpdatedCallback) {
        if let fetchError = fetchError {
            
            if let delay = delay {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    callback(nil, fetchError)
                }
            } else {
                callback(nil, fetchError)
            }
        } else {
            super.fetch(callback)
        }
    }
    
}
