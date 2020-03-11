//
//  SortingScreenUITests.swift
//  LocalPlacesUITests
//
//  Created by Bruno Rigo Werminghoff on 11/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class SortingScreenUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testSortingOptionsCells() {
        
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.noLayerAnimations.rawValue,
            AppLaunchArguments.noViewAnimations.rawValue]
        app.activate()
        
        app.buttons[Accessibility.sortButton.identifier].tap()
        
        validateSortingChecked(for: app, checkedAt: 2)
        
        for i in 0..<8{
            app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(i).identifier].tap()
            app.buttons[Accessibility.sortButton.identifier].tap()
            validateSortingChecked(for: app, checkedAt: i)
        }
        
        app.terminate()
        
    }
    
    private func validateSortingChecked(for app: XCUIApplication, checkedAt index: Int) {
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(0).identifier].label, "Name (ascending)")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(0).identifier].value as! String, index == 0 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(1).identifier].label, "Name (descending)")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(1).identifier].value as! String, index == 1 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(2).identifier].label, "Rating (high->low)")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(2).identifier].value as! String, index == 2 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(3).identifier].label, "Rating (low->high)")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(3).identifier].value as! String, index == 3 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(4).identifier].label, "Distance (low->high)")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(4).identifier].value as! String, index == 4 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(5).identifier].label, "Distance (high->low)")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(5).identifier].value as! String, index == 5 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(6).identifier].label, "Open now")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(6).identifier].value as! String, index == 6 ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(7).identifier].label, "Closed now")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.sortingTypeLabel(7).identifier].value as! String, index == 7 ? Accessibility.statusChecked : Accessibility.statusNone)
    }
    
}
