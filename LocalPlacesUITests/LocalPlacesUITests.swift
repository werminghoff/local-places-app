//
//  LocalPlacesUITests.swift
//  LocalPlacesUITests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class LocalPlacesUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }

    func testMainScreenCellsWithLocaleUS() {
        
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.noLayerAnimations.rawValue,
            AppLaunchArguments.setLocale.rawValue,
            AppLaunchArguments.locale_US.rawValue]
        app.activate()
        
        let firstCell = app.tables.cells[Accessibility.placeCell(0).identifier]
        XCTAssertEqual(firstCell.staticTexts[Accessibility.placeName(0).identifier].label, "Place 3 (0.117mi)")
        XCTAssertEqual(firstCell.staticTexts[Accessibility.placeRating(0).identifier].label, "Rating: 4.8")
        XCTAssertEqual(firstCell.images[Accessibility.placeOpen(0).identifier].label, Accessibility.statusClosed)
        
        let secondCell = app.tables.cells[Accessibility.placeCell(1).identifier]
        XCTAssertEqual(secondCell.staticTexts[Accessibility.placeName(1).identifier].label, "Place 2 (0.204mi)")
        XCTAssertEqual(secondCell.staticTexts[Accessibility.placeRating(1).identifier].label, "Rating: 4.1")
        XCTAssertEqual(secondCell.images[Accessibility.placeOpen(1).identifier].label, Accessibility.statusOpen)
        
        let thirdCell = app.tables.cells[Accessibility.placeCell(2).identifier]
        XCTAssertEqual(thirdCell.staticTexts[Accessibility.placeName(2).identifier].label, "Place 4 with amazingly long name for whatever reason (0.207mi)")
        XCTAssertEqual(thirdCell.staticTexts[Accessibility.placeRating(2).identifier].label, "Rating: 2.2")
        XCTAssertEqual(thirdCell.images[Accessibility.placeOpen(2).identifier].label, Accessibility.statusOpen)
        
        let fourthCell = app.tables.cells[Accessibility.placeCell(3).identifier]
        XCTAssertEqual(fourthCell.staticTexts[Accessibility.placeName(3).identifier].label, "Place 1 (0.207mi)")
        XCTAssertEqual(fourthCell.staticTexts[Accessibility.placeRating(3).identifier].label, "Rating unavailable")
        XCTAssertEqual(fourthCell.images[Accessibility.placeOpen(3).identifier].label, "")
        
        app.terminate()
    }
    
    func testMainScreenCellsWithLocaleBR() {
        
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.noLayerAnimations.rawValue,
            AppLaunchArguments.setLocale.rawValue,
            AppLaunchArguments.locale_BR.rawValue]
        app.activate()
        
        let firstCell = app.tables.cells[Accessibility.placeCell(0).identifier]
        XCTAssertEqual(firstCell.staticTexts[Accessibility.placeName(0).identifier].label, "Place 3 (0,188km)")
        XCTAssertEqual(firstCell.staticTexts[Accessibility.placeRating(0).identifier].label, "Rating: 4.8")
        XCTAssertEqual(firstCell.images[Accessibility.placeOpen(0).identifier].label, Accessibility.statusClosed)
        
        let secondCell = app.tables.cells[Accessibility.placeCell(1).identifier]
        XCTAssertEqual(secondCell.staticTexts[Accessibility.placeName(1).identifier].label, "Place 2 (0,328km)")
        XCTAssertEqual(secondCell.staticTexts[Accessibility.placeRating(1).identifier].label, "Rating: 4.1")
        XCTAssertEqual(secondCell.images[Accessibility.placeOpen(1).identifier].label, Accessibility.statusOpen)
        
        let thirdCell = app.tables.cells[Accessibility.placeCell(2).identifier]
        XCTAssertEqual(thirdCell.staticTexts[Accessibility.placeName(2).identifier].label, "Place 4 with amazingly long name for whatever reason (0,332km)")
        XCTAssertEqual(thirdCell.staticTexts[Accessibility.placeRating(2).identifier].label, "Rating: 2.2")
        XCTAssertEqual(thirdCell.images[Accessibility.placeOpen(2).identifier].label, Accessibility.statusOpen)
        
        let fourthCell = app.tables.cells[Accessibility.placeCell(3).identifier]
        XCTAssertEqual(fourthCell.staticTexts[Accessibility.placeName(3).identifier].label, "Place 1 (0,333km)")
        XCTAssertEqual(fourthCell.staticTexts[Accessibility.placeRating(3).identifier].label, "Rating unavailable")
        XCTAssertEqual(fourthCell.images[Accessibility.placeOpen(3).identifier].label, "")
        
        app.terminate()
        
    }
    
    func testMainScreenErrorOnFetchLocation() {
        
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.withDelayedServices.rawValue,
            AppLaunchArguments.withMocksFailingLocation.rawValue,
            AppLaunchArguments.noViewAnimations.rawValue,
            AppLaunchArguments.setLocale.rawValue,
            AppLaunchArguments.locale_BR.rawValue]
        app.activate()
        
        XCTAssertTrue(app.alerts.staticTexts["Error while getting user's location"].waitForExistence(timeout: 5))
        
        app.terminate()
        
    }
    
    func testMainScreenErrorOnFetchPlaces() {
        
        let app = XCUIApplication()
        app.launchArguments = [
            AppLaunchArguments.withMocks.rawValue,
            AppLaunchArguments.withDelayedServices.rawValue,
            AppLaunchArguments.withMocksFailingFetchNearby.rawValue,
            AppLaunchArguments.noViewAnimations.rawValue,
            AppLaunchArguments.setLocale.rawValue,
            AppLaunchArguments.locale_BR.rawValue]
        app.activate()
        
        XCTAssertTrue(app.alerts.staticTexts["Error while fetching nearby places"].waitForExistence(timeout: 5))
        
        app.terminate()
        
    }
    
}
