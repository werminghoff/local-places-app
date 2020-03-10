//
//  MockedSortingTypePicker.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedSortingTypePicker: SortingTypePickerViewController {
    
    func select(_ value: SortingType) {
        callback?(value)
    }
    
}
