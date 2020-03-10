//
//  MockedFilterTypePicker.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedFilterTypePicker: FilterTypePickerViewController {
    
    func select(_ values: [FilterType]) {
        callback?(values)
    }
    
}
