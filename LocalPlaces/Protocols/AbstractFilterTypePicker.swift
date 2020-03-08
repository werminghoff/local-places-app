//
//  AbstractFilterTypePicker.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

protocol AbstractFilterTypePicker: class {
    var callback: (([FilterType]) -> Void)? { get set }
    var selectedValues: Set<FilterType> { get set }
}
