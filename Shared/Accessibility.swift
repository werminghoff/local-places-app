//
//  Accessibility.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

enum Accessibility {
    case placeCell(Int)
    case placeRating(Int)
    case placeOpen(Int)
    case placeName(Int)
    
    static let statusOpen = "open"
    static let statusClosed = "closed"
    
    var identifier: String {
        switch self {
        case .placeCell(let row): return "place_cell_\(row)"
        case .placeRating(let row): return "place_rating_\(row)"
        case .placeOpen(let row): return "place_open_\(row)"
        case .placeName(let row): return "place_name_\(row)"
            
        }
    }
    
}
