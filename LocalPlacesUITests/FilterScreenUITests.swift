//
//  FilterScreenUITests.swift
//  LocalPlacesUITests
//
//  Created by Bruno Rigo Werminghoff on 11/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest

class FilterScreenUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }

    func testFilteringOptionsCellas() {
        
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.noLayerAnimations.rawValue,
            AppLaunchArguments.noViewAnimations.rawValue
        ]
        app.activate()
        
        app.buttons[Accessibility.filterButton.identifier].tap()
        
        validateFilterChecked(for: app, checkedAt: [])
        for i in 0..<4{
            app.tables.cells.staticTexts[Accessibility.filterTypeLabel(i).identifier].tap()
        }
        validateFilterChecked(for: app, checkedAt: [0,1,2,3])
        
        app.buttons[Accessibility.cancelButton.identifier].tap()

        app.buttons[Accessibility.filterButton.identifier].tap()
        validateFilterChecked(for: app, checkedAt: [])
        for i in 0..<2{
            app.tables.cells.staticTexts[Accessibility.filterTypeLabel(i).identifier].tap()
        }
        validateFilterChecked(for: app, checkedAt: [0,1])
        app.buttons[Accessibility.saveButton.identifier].tap()
        app.buttons[Accessibility.filterButton.identifier].tap()
        validateFilterChecked(for: app, checkedAt: [0,1])
        app.buttons[Accessibility.saveButton.identifier].tap()
        
        app.terminate()
        
    }
    
    private func validateFilterChecked(for app: XCUIApplication, checkedAt indexes: Set<Int>) {
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(0).identifier].label, "With rating")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(0).identifier].value as! String, indexes.contains(0) ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(1).identifier].label, "Without rating")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(1).identifier].value as! String, indexes.contains(1) ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(2).identifier].label, "Open")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(2).identifier].value as! String, indexes.contains(2) ? Accessibility.statusChecked : Accessibility.statusNone)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(3).identifier].label, "Closed")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.filterTypeLabel(3).identifier].value as! String, indexes.contains(3) ? Accessibility.statusChecked : Accessibility.statusNone)
        
    }

}
