//
//  SortingTypesTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class SortingTypesTests: XCTestCase {
    
    func testSortingTypesNamesAreNotEmpty() {
        for type in SortingType.allCases {
            XCTAssertEqual(type.getName().isEmpty, false)
        }
    }
    
}
