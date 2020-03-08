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
        
        // Add URL parameters
        let urlParams = [
            "location": "\(coordinate.latitude),\(coordinate.longitude)",
            "radius": "500",
            "key": apiKey,
        ]

        // Fetch Request
        AF.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json",
                   method: .get,
                   parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GooglePlaceModel.Response.self) { (response) in
                
                let responseObject = try? response.result.get()
                
                if let responseObject = responseObject {
                    callback?(responseObject.results, nil)
                } else {
                    callback?(nil, "Failed to fetch local places")
                }
            }
        
    }
    
    func fetchPhoto(for place: AbstractPlace, callback: FetchPhotoCallback?) {
        
    }
    
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        
    }
    
}
