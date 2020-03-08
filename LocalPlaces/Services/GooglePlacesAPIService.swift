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
        
        let types = ["bar" /*, "cafe", "restaurant" */]
        let group = DispatchGroup()
        
        var results: [GooglePlaceModel.Place] = []
        var hasError: Bool = false
        
        for type in types {
            // Add URL parameters
            let urlParams = [
                "location": "\(coordinate.latitude),\(coordinate.longitude)",
                "radius": "500",
                "type": type,
                "key": apiKey,
            ]
            
            // Fetch Request
            group.enter()
            AF.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json",
                       method: .get,
                       parameters: urlParams)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: GooglePlaceModel.Response.self) { (response) in
                    
                    let responseObject = try? response.result.get()
                    
                    if let responseObject = responseObject {
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
        
    }
    
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        
    }
    
}
