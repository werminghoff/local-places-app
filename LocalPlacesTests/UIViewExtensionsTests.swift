//
//  UIViewExtensionTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class UIViewExtensionTests: XCTestCase {
    
    func testClassAutoLayoutSetsAutoLayoutFlag() {
        let view = UIView.autoLayout()
        XCTAssertEqual(view.translatesAutoresizingMaskIntoConstraints, false)
    }
    
    func testInstanceAutoLayoutSetsAutoLayoutFlag() {
        let view = UIView().autoLayout()
        XCTAssertEqual(view.translatesAutoresizingMaskIntoConstraints, false)
    }
    
}
