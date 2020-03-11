//
//  DetailViewUITests.swift
//  LocalPlacesUITests
//
//  Created by Bruno Rigo Werminghoff on 11/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class DetailViewUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }
    
    func testDetailsScreen_LocaleUS() {
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.noLayerAnimations.rawValue,
            AppLaunchArguments.noViewAnimations.rawValue,
            AppLaunchArguments.setLocale.rawValue,
            AppLaunchArguments.locale_US.rawValue]
        app.activate()
        
        let firstPlace = app.tables.cells[Accessibility.placeCell(0).identifier]
        firstPlace.tap()
        
        XCTAssertEqual(app.staticTexts[Accessibility.detailRating.identifier].label, "Average rating: 4.8")
        XCTAssertEqual(app.images[Accessibility.detailOpen.identifier].value as! String, Accessibility.statusClosed)
        XCTAssertEqual(app.staticTexts[Accessibility.detailName.identifier].label, "Place 3 (0.117mi)")
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.reviewName(0).identifier].label, "David")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.reviewRating(0).identifier].label, "Rating: 4.0")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.reviewText(0).identifier].label, "Phasellus rhoncus porta tristique.")
        
        app.buttons["Local Places"].tap()
        app.terminate()
    }
    
    func testDetailsScreen_LocaleBR() {
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.noLayerAnimations.rawValue,
            AppLaunchArguments.noViewAnimations.rawValue,
            AppLaunchArguments.setLocale.rawValue,
            AppLaunchArguments.locale_BR.rawValue]
        app.activate()
        
        let firstPlace = app.tables.cells[Accessibility.placeCell(0).identifier]
        firstPlace.tap()
        
        XCTAssertEqual(app.staticTexts[Accessibility.detailRating.identifier].label, "Average rating: 4.8")
        XCTAssertEqual(app.images[Accessibility.detailOpen.identifier].value as! String, Accessibility.statusClosed)
        XCTAssertEqual(app.staticTexts[Accessibility.detailName.identifier].label, "Place 3 (0,188km)")
        XCTAssertEqual(app.images[Accessibility.detailPhoto.identifier].value as! String, Accessibility.statusPhotoLoaded)
        
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.reviewName(0).identifier].label, "David")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.reviewRating(0).identifier].label, "Rating: 4.0")
        XCTAssertEqual(app.tables.cells.staticTexts[Accessibility.reviewText(0).identifier].label, "Phasellus rhoncus porta tristique.")
        
        app.buttons["Local Places"].tap()
        app.terminate()
    }
    
}
