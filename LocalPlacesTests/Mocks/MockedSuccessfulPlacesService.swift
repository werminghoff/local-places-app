//
//  MockedSuccessfulPlacesService.swift
//  LocalPlacesTests
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
@testable import LocalPlaces

class MockedSuccessfulPlacesService: AbstractPlacesService {
    
    typealias PlaceID = String
    struct MockedPlaceModel: AbstractPlace {
        var id: String
        var name: String
        var coordinate: Coordinate
        var isOpenNow: Bool?
        var rating: Double?
        var photoIdentifier: String?
        var distance: Double
        var formattedDistance: String
    }
    
    struct MocketReviewModel: AbstractReview {
        var username: String
        var rating: Double
        var text: String
    }
    
    let places: [AbstractPlace] = [
        MockedPlaceModel(id: "place1",
                         name: "Place 1",
                         coordinate: Coordinate(latitude: -30.024834, longitude: -51.183043),
                         isOpenNow: nil,
                         rating: nil,
                         photoIdentifier: nil,
                         distance: 0.0,
                         formattedDistance: ""),
        MockedPlaceModel(id: "place2",
                         name: "Place 2",
                         coordinate: Coordinate(latitude: -30.024779, longitude: -51.182953),
                         isOpenNow: true,
                         rating: 4.1,
                         photoIdentifier: nil,
                         distance: 0.0,
                         formattedDistance: ""),
        MockedPlaceModel(id: "place3",
                         name: "Place 3",
                         coordinate: Coordinate(latitude: -30.023460, longitude: -51.183779),
                         isOpenNow: false,
                         rating: 4.8,
                         photoIdentifier: "identifier",
                         distance: 0.0,
                         formattedDistance: ""),
        MockedPlaceModel(id: "place4",
                         name: "Place 4 with amazingly long name for whatever reason",
                         coordinate: Coordinate(latitude: -30.024679, longitude: -51.182153),
                         isOpenNow: true,
                         rating: 2.2,
                         photoIdentifier: nil,
                         distance: 0.0,
                         formattedDistance: ""),
    ]
    
    let reviews: [PlaceID: [AbstractReview]] = [
        "place1": [
            MocketReviewModel(username: "Bruno", rating: 4.5, text: "Lorem ipsum dolor sit amet."),
            MocketReviewModel(username: "John", rating: 1.0, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In condimentum."),
            MocketReviewModel(username: "Jenny", rating: 2.0, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque rutrum vestibulum dui ut fringilla. Nam sit amet mauris et dui.")
        ],
        "place2": [
            MocketReviewModel(username: "Pablo", rating: 1.0, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent gravida velit orci, sed consectetur magna lobortis et."),
            MocketReviewModel(username: "Karen", rating: 5.0, text: "Sed sollicitudin, arcu a efficitur pretium, turpis magna cursus ex, non faucibus elit ante ut odio"),
            MocketReviewModel(username: "James", rating: 4.0, text: "Etiam feugiat nisi commodo ex efficitur, a suscipit lorem auctor. Aliquam elit sem, tincidunt id metus et, sagittis dictum purus. "),
            MocketReviewModel(username: "Maria", rating: 2.0, text: "Etiam feugiat nisi commodo ex efficitur, a suscipit lorem auctor. Aliquam elit sem, tincidunt id metus et, sagittis dictum purus. ")
        ],
        "place3": [
            MocketReviewModel(username: "David", rating: 4.0, text: "Phasellus rhoncus porta tristique. Donec quam sapien, viverra eget eleifend eget, cursus non turpis. Vestibulum eget enim nec augue semper tristique. Fusce vel lobortis est. Suspendisse blandit, ligula et convallis tempor, massa arcu vehicula felis, porta varius enim arcu sit amet lectus."),
            MocketReviewModel(username: "Pablo Garcia Gomez Herrero Long Name", rating: 4.0, text: "Phasellus rhoncus porta tristique. Donec quam sapien, viverra eget eleifend eget, cursus non turpis. Vestibulum eget enim nec augue semper tristique. Fusce vel lobortis est. Suspendisse blandit, ligula et convallis tempor, massa arcu vehicula felis, porta varius enim arcu sit amet lectus."),
        ],
        "place4": []
    ]
    
    func fetchNear(coordinate: Coordinate, callback: FetchPlacesCallback?) {
        callback?(self.places, nil)
    }
    
    
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        let reviews = self.reviews[place.id] ?? []
        callback?(reviews, nil)
    }
    
    func fetchPhoto(for place: AbstractPlace, callback: FetchPhotoCallback?) {
        if place.photoIdentifier != nil {
            callback?(#imageLiteral(resourceName: "mock-bar-photo"), nil)
        } else {
            callback?(nil, nil)
        }
    }
    
}

