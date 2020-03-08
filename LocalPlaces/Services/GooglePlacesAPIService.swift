//
//  GooglePlacesAPIService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import Alamofire

class GooglePlacesAPIService: NSObject, AbstractPlacesService {
    
    private let apiKey = ""
    
    func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?) {
        
        
        
    }
    
    func fetchPhoto(for place: AbstractPlace, callback: FetchPhotoCallback?) {
        
    }
    
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        
    }
    
}
