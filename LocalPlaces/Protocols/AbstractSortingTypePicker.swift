//
//  AbstractSortingTypePicker.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

protocol AbstractSortingTypePicker: class {
    var callback: ((SortingType) -> Void)? { get set }
    var selectedValue: SortingType? { get set }
}
