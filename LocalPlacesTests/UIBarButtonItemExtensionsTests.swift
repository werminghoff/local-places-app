//
//  UIBarButtonItemExtensionsTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class UIBarButtonItemExtensionsTests: XCTestCase {
    
    private var wasButtonTapped: Bool = false
    
    private func sendTapEvent(for button: UIBarButtonItem) {
        let action = button.action
        let target = button.target
        _ = target?.perform?(action)
    }
    
    /**
    - Given: App is running
    - When: Something needs a UIBarButtonItem styled for canceling an action
    - Then: The button is tappable and is able to run its action on its target
    */
    func testCancelButtonWorks() {
        let button = UIBarButtonItem.cancel(target: self, action: #selector(buttonTapped))
        XCTAssertEqual(wasButtonTapped, false)
        XCTAssertEqual(button.isEnabled, true)
        sendTapEvent(for: button)
        XCTAssertEqual(wasButtonTapped, true)
    }
    
    /**
    - Given: App is running
    - When: Something needs a UIBarButtonItem styled for saving an action
    - Then: The button is tappable and is able to run its action on its target
    */
    func testSaveButtonWorks() {
        let button = UIBarButtonItem.save(target: self, action: #selector(buttonTapped))
        XCTAssertEqual(wasButtonTapped, false)
        XCTAssertEqual(button.isEnabled, true)
        sendTapEvent(for: button)
        XCTAssertEqual(wasButtonTapped, true)
    }
    
    /**
    - Given: App is running
    - When: Something needs a UIBarButtonItem styled for sorting a list
    - Then: The button is tappable and is able to run its action on its target
    */
    func testSortingButtonWorks() {
        let button = UIBarButtonItem.sorting(target: self, action: #selector(buttonTapped))
        XCTAssertEqual(wasButtonTapped, false)
        XCTAssertEqual(button.isEnabled, true)
        sendTapEvent(for: button)
        XCTAssertEqual(wasButtonTapped, true)
    }
    
    /**
    - Given: App is running
    - When: Something needs a UIBarButtonItem styled for filtering a list
    - Then: The button is tappable and is able to run its action on its target
    */
    func testFilterButtonWorks() {
        let button = UIBarButtonItem.filter(target: self, action: #selector(buttonTapped))
        XCTAssertEqual(wasButtonTapped, false)
        XCTAssertEqual(button.isEnabled, true)
        sendTapEvent(for: button)
        XCTAssertEqual(wasButtonTapped, true)
    }
    
    @objc func buttonTapped() {
        wasButtonTapped = true
    }
}
