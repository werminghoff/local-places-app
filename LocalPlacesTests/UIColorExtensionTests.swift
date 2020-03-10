//
//  UIColorExtensionTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class UIColorExtensionTests: XCTestCase {

    func testCustomColorsAreNotNil() {
        
        var color: UIColor? = .titleColor
        XCTAssertNotNil(color)
        
        color = .subtitleColor
        XCTAssertNotNil(color)
        
    }
    
}
