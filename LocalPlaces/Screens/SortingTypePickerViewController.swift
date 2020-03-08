//
//  SortingTypePickerViewController.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

class SortingTypePickerViewController: SingleEnumPickerViewController<SortingType>, AbstractSortingTypePicker {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sorting"
    }
    
}
