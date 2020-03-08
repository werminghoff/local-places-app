//
//  AbstractPlacesService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import CoreLocation

protocol AbstractPlacesService: class {
    
    typealias ErrorMessage = String
    typealias FetchPlacesCallback = (([AbstractPlace]?, ErrorMessage?) -> Void)
    typealias FetchReviewsCallback = (([AbstractReview]?, ErrorMessage?) -> Void)
    
    func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?)
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?)
    
}
