//
//  Place.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

/// Struct that holds any required info from Google Places API
struct GooglePlaceModel {
    
    struct Location: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
        
        let latitude: Double
        let longitude: Double
        
    }
    
    struct Geometry: Decodable {
        enum CodingKeys: String, CodingKey {
            case location
        }

        let location: Location
    }
    
    struct Photo: Decodable {
        enum CodingKeys: String, CodingKey {
            case reference = "photo_reference"
        }

        let reference: String?
    }
    
    struct OpeningHours: Decodable {
        enum CodingKeys: String, CodingKey {
            case openNow = "open_now"
        }
        
        let openNow: Bool?
    }
    
    struct Place: Decodable {
        enum CodingKeys: String, CodingKey {
            case geometry
            case iconUrl = "icon"
            case photos
            case id
            case name
            case openingHours = "opening_hours"
            case rating
        }

        let name: String
        let geometry: Geometry
        let iconUrl: String?
        let photos: [Photo]?
        let openingHours: OpeningHours?
        let id: String
        let rating: Double?
        var distance: Double = 0.0
        var formattedDistance: String = ""
    }

    struct Response: Decodable {
        
        enum Status: String, Decodable {
            /// OK indicates that no errors occurred; the place was successfully detected and at least one result was returned.
            case ok = "OK"
            
            /// ZERO_RESULTS indicates that the search was successful but returned no results. This may occur if the search was passed a latlng in a remote location.
            case zeroResults = "ZERO_RESULTS"
            
            // OVER_QUERY_LIMIT indicates that you are over your quota.
            case overQueryLimit = "OVER_QUERY_LIMIT"
            
            /// REQUEST_DENIED indicates that your request was denied, generally because of lack of an invalid key parameter.
            case requestDenied = "REQUEST_DENIED"
            
            /// INVALID_REQUEST generally indicates that a required query parameter (location or radius) is missing.
            case invalidRequest = "INVALID_REQUEST"
            
            /// UNKNOWN_ERROR indicates a server-side error; trying again may be successful.
            case unknownError = "UNKNOWN_ERROR"
        }
        
        enum CodingKeys: String, CodingKey {
            case nextPageToken = "next_page_token"
            case results
            case status = "status"
        }
        
        /// `next_page_token` contains a token that can be used to return up to 20 additional results. A next_page_token will not be returned if there are no additional results to display. The maximum number of results that can be returned is 60. There is a short delay between when a next_page_token is issued, and when it will become valid.
        let nextPageToken: String?
        
        /// `results` contains an array of places, with information about each. See Search Results for information about these results. The Places API returns up to 20 establishment results per query. Additionally, political results may be returned which serve to identify the area of the request.
        let results: [Place]
        
        /// `status` contains metadata on the request.
        let status: Status?
        
    }

}

//// MARK: - AbstractPlace
extension GooglePlaceModel.Place: AbstractPlace {
    
    var coordinate: Coordinate { Coordinate(latitude: self.geometry.location.latitude, longitude: self.geometry.location.longitude) }
    var isOpenNow: Bool? { self.openingHours?.openNow }
    var photoUrls: [URL] { [] } // TODO: implement
    
}
