//
//  AbstractReview.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

protocol AbstractReview {
    
    /**
     This username of the person who did this review
     */
    var username: String { get }
    
    /**
     This rating provided by the person who did this review
     */
    var rating: Double { get }
    
    /**
    The text/description provided by the person who did this review
     */
    var text: String { get }
    
}

