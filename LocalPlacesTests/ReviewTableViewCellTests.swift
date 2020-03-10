//
//  ReviewTableViewCellTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class ReviewTableViewCellTests: XCTestCase {
    
    func testCellDoesntCrash() {
        // Doesnt't crash with default init
        _ = ReviewTableViewCell()
        
        // Doesnt't crash with frame-based init
        _ = ReviewTableViewCell(frame: .zero)
        
        // Doesnt't crash with style/identifier init
        _ = ReviewTableViewCell(style: .default, reuseIdentifier: "")
        
        // Doesnt't crash while registering & dequeueing
        let tableView = UITableView()
        tableView.register(ReviewTableViewCell.self)
        _ = tableView.dequeueReusableCell(ReviewTableViewCell.self, for: IndexPath(row: 0, section: 0))
        
        // Doesn't crash while setting a review to it (nil and non-nil value)
        let cell = ReviewTableViewCell()
        cell.review = nil
        cell.review = MockedSuccessfulPlacesService.MocketReviewModel(username: "Bruno", rating: 1.0, text: "Nice")
    }
}
