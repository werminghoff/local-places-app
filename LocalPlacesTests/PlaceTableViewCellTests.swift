//
//  PlaceTableViewCellTests.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import XCTest
@testable import LocalPlaces

class PlaceTableViewCellTests: XCTestCase {
    
    func testCellDoesntCrash() {
        // Doesnt't crash with default init
        _ = PlaceTableViewCell()
        
        // Doesnt't crash with frame-based init
        _ = PlaceTableViewCell(frame: .zero)
        
        // Doesnt't crash with style/identifier init
        _ = PlaceTableViewCell(style: .default, reuseIdentifier: "")
        
        // Doesnt't crash while registering & dequeueing
        let tableView = UITableView()
        tableView.register(PlaceTableViewCell.self)
        _ = tableView.dequeueReusableCell(PlaceTableViewCell.self, for: IndexPath(row: 0, section: 0))
        
        // Doesn't crash while setting a place to it (nil and non-nil value)
        let cell = PlaceTableViewCell()
        cell.place = nil
        cell.place = MockedSuccessfulPlacesService.MockedPlaceModel(id: "",
                                                                    name: "",
                                                                    coordinate: Coordinate(latitude: 1.0, longitude: 1.0),
                                                                    isOpenNow: false,
                                                                    rating: nil,
                                                                    photoIdentifier: "",
                                                                    distance: 2.0,
                                                                    formattedDistance: "2m")
    }
}
