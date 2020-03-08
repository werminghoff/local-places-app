//
//  MockedPlacesService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

class MockedPlacesService: AbstractPlacesService {
    
    private struct MockedPlaceModel: AbstractPlace {
        var name: String
        var coordinate: Coordinate
        var isOpenNow: Bool?
        var rating: Double?
        var photoUrls: [URL]
    }
    
    private let places = [
        MockedPlaceModel(name: "Place 1",
                         coordinate: Coordinate(latitude: -30.024834, longitude: -51.183043),
                         isOpenNow: nil,
                         rating: nil,
                         photoUrls: []),
        MockedPlaceModel(name: "Place 2",
                         coordinate: Coordinate(latitude: -30.024779, longitude: -51.182953),
                         isOpenNow: true,
                         rating: 4.1,
                         photoUrls: []),
        MockedPlaceModel(name: "Place 3",
                         coordinate: Coordinate(latitude: -30.023460, longitude: -51.183779),
                         isOpenNow: false,
                         rating: 4.8,
                         photoUrls: [
                            URL(string: "https://media-cdn.tripadvisor.com/media/photo-m/1280/16/ea/16/6f/french-23-musujacy-z.jpg")!
        ])
    ]
    
    func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback?(self.places, nil)
        }
    }
    
}
