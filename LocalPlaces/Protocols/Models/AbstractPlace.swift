//
//  AbstractPlace.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

protocol AbstractPlace {
    
    /**
     This place's identifier
     */
    var id: String { get }

    /**
     This place's name
     */
    var name: String { get }
    
    /**
     This place's location's coordinate
     */
    var coordinate: Coordinate { get }
    
    /**
    This place's current open/closed status
     - Note: A nil value indicates that the datasource used doesn't know if the place is currently open
     */
    var isOpenNow: Bool? { get }
    
    /**
     This place's user rating, ranging from 0 (lowest/worst score) to 5 (highest/best score)
     - Note: A nil value indicates that the datasource used doesn't provide ratings for this place
     */
    var rating: Double? { get }
    
    /**
    This place's photo identifier
     */
    var photoIdentifier: String? { get }
    
    /**
     This place's distance to the current location.
     - Note: This value should be calculated and stored by the application
     */
    var distance: Double { get set }
    
    /**
     A string representation of this place's distance to the current location
     - Note: This value should be calculated and stored by the application
     */
    var formattedDistance: String { get set }
}

