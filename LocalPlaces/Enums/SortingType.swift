//
//  SortingType.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

enum SortingType: Int, SelectableEnumerator {
    
    case nameAscending = 0
    case nameDescending
    case ratingHigher
    case ratingLower
    case distanceLower
    case distanceHigher
    case open
    case closed
    
    func getName() -> String {
        switch self {
        case .nameAscending:
            return "Name (ascending)"
        case .nameDescending:
            return "Name (descending)"
        case .ratingHigher:
            return "Rating (high->low)"
        case .ratingLower:
            return "Rating (low->high)"
        case .distanceHigher:
            return "Distance (high->low)"
        case .distanceLower:
            return "Distance (low->high)"
        case .open:
            return "Open now"
        case .closed:
            return "Closed now"
        }
    }
}
