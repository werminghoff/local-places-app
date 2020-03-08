//
//  FilterOption.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

enum FilterType: Int, SelectableEnumerator {
    
    case withRating = 0
    case withoutRating
    case open
    case closed
    
    func getName() -> String {
        switch self {
        case .withRating:
            return "With rating"
        case .withoutRating:
            return "Without rating"
        case .open:
            return "Open"
        case .closed:
            return "Closed"
        }
    }
}
