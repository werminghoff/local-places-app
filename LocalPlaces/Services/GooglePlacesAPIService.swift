//
//  GooglePlacesAPIService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class GooglePlacesAPIService: NSObject, AbstractPlacesService {
    
    private let apiKey = ""
    
    func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?) {
        
        let types = ["bar" , "cafe", "restaurant"]
        let group = DispatchGroup()
        
        var results: [GooglePlaceModel.Place] = []
        var hasError: Bool = false
        
        for type in types {
            // Parameters
            let urlParams = [
                "location": "\(coordinate.latitude),\(coordinate.longitude)",
                "radius": "500",
                "type": type,
                "key": apiKey,
            ]
            
            // Fetch
            group.enter()
            AF.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json",
                       method: .get,
                       parameters: urlParams)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: GooglePlaceModel.ResponseMultiple.self) { (response) in
                    
                    let responseObject = try? response.result.get()
                    
                    if let responseObject = responseObject, responseObject.status == .ok {
                        results.append(contentsOf: responseObject.results)
                    } else {
                        hasError = true
                    }
                    group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if hasError {
                callback?(nil, "Failed to fetch local places")
            } else {
                
                typealias PlaceID = String
                // Just in case multiple categories return the same place, I'll remove duplicates by hashing their IDs
                var uniquePlaces: [PlaceID: GooglePlaceModel.Place] = [:]
                results.forEach {
                    uniquePlaces[$0.id] = $0
                }
                let places: [AbstractPlace] = uniquePlaces.map({ $0.value })
                callback?(places, nil)
            }
        }
        
        
    }
    
    func fetchPhoto(for place: AbstractPlace, callback: FetchPhotoCallback?) {
        if let reference = place.photoIdentifier {
            
            // Parameters
            let urlParams = [
                "photoreference": reference,
                "maxheight": "400",
                "key": apiKey,
            ]
            
            // Fetch
            AF.request("https://maps.googleapis.com/maps/api/place/photo",
                       method: .get,
                       parameters: urlParams)
                .validate(statusCode: 200..<300)
                .responseData { (response) in
                    let responseData = try? response.result.get()
                    if let responseData = responseData,
                        let image = UIImage(data: responseData) {
                        callback?(image, nil)
                    } else {
                        callback?(nil, "Failed to fetch place's image")
                    }
            }
            
        } else {
            callback?(nil, nil) // don't consider it an error, we just don't have an image for it
        }
        
    }
    
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        
        //
        // Parameters
        let urlParams = [
            "place_id": place.id,
            "fields": "review",
            "key": apiKey,
        ]
        
        // Fetch
        AF.request("https://maps.googleapis.com/maps/api/place/details/json",
                   method: .get,
                   parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GooglePlaceModel.ResponseReviews.self) { (response) in
                
                let responseObject = try? response.result.get()
                
                if let responseObject = responseObject,
                    let reviews = responseObject.result?.reviews {
                    callback?(reviews, nil)
                } else {
                    callback?(nil, "Failed to fetch reviews")
                }
        }
    }
    
}
