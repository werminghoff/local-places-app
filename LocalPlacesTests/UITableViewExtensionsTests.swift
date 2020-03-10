//
//  UITableViewExtensionsTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class UITableViewExtensionsTests: XCTestCase {
    
    private class CustomTableViewCell: UITableViewCell { }
    
    func testCellTypeRegistersAndDequeuesWithDefaultIdentifier() {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self)
        tableView.register(UITableViewCell.self)
        
        let customCell = tableView.dequeueReusableCell(CustomTableViewCell.self, for: IndexPath(row: 0, section: 0))
        let defaultCell = tableView.dequeueReusableCell(UITableViewCell.self, for: IndexPath(row: 0, section: 0))
        
        XCTAssert(type(of: CustomTableViewCell()).isEqual(type(of: customCell)))
        XCTAssert(type(of: UITableViewCell()).isEqual(type(of: defaultCell)))
        
        XCTAssertEqual(CustomTableViewCell.defaultIdentifier, "CustomTableViewCell")
        XCTAssertEqual(UITableViewCell.defaultIdentifier, "UITableViewCell")
        
    }
    
}

