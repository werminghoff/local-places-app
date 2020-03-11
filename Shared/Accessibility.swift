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
    
    case cancelButton
    case saveButton
    
    case sortButton
    case sortingTypeLabel(Int)
    
    case filterButton
    case filterTypeLabel(Int)
    
    case detailRating
    case detailOpen
    case detailName
    case detailPhoto
    
    case reviewName(Int)
    case reviewText(Int)
    case reviewRating(Int)
    
    case errorLoadingPhotoLabel
    case errorLoadingReviewsLabel
    
    static let statusOpen = "open"
    static let statusClosed = "closed"
    static let statusChecked = "checked"
    static let statusNone = ""
    static let statusPhotoLoaded = "photo_loaded"
    
    var identifier: String {
        switch self {
        case .placeCell(let row): return "place_cell_\(row)"
        case .placeRating(let row): return "place_rating_\(row)"
        case .placeOpen(let row): return "place_open_\(row)"
        case .placeName(let row): return "place_name_\(row)"
            
        case .cancelButton: return "cancel_button"
        case .saveButton: return "save_button"
            
        case .sortButton: return "sort_button"
        case .sortingTypeLabel(let row): return "sorting_type_\(row)"
            
        case .filterButton: return "filter_button"
        case .filterTypeLabel(let row): return "filter_type_\(row)"
            
        case .detailRating: return "detail_rating"
        case .detailOpen: return "detail_open"
        case .detailName: return "detail_name"
        case .detailPhoto: return "detail_photo"
            
        case .reviewName(let row): return "review_name_\(row)"
        case .reviewText(let row): return "review_text_\(row)"
        case .reviewRating(let row): return "review_rating(\(row)"
        
        case .errorLoadingPhotoLabel: return "error_loading_photo"
        case .errorLoadingReviewsLabel: return "error_loading_reviews"
        }
    }
    
}
