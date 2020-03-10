//
//  FilterTypesTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class FilterTypesTests: XCTestCase {
    
    func testFilterTypesNamesAreNotEmpty() {
        for type in FilterType.allCases {
            XCTAssertEqual(type.getName().isEmpty, false)
        }
    }
    
}
