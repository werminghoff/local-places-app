//
//  MockedPlacesService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

class MockedPlacesService: AbstractPlacesService {
    
    typealias PlaceID = String
    private struct MockedPlaceModel: AbstractPlace {
        var id: String
        var name: String
        var coordinate: Coordinate
        var isOpenNow: Bool?
        var rating: Double?
        var photoUrls: [URL]
        var distance: Double
        var formattedDistance: String
    }
    
    private struct MocketReviewModel: AbstractReview {
        var username: String
        var rating: Double
        var text: String
    }
    
    private let places: [AbstractPlace] = [
        MockedPlaceModel(id: "place1",
                         name: "Place 1",
                         coordinate: Coordinate(latitude: -30.024834, longitude: -51.183043),
                         isOpenNow: nil,
                         rating: nil,
                         photoUrls: [],
                         distance: 0.0,
                         formattedDistance: ""),
        MockedPlaceModel(id: "place2",
                         name: "Place 2",
                         coordinate: Coordinate(latitude: -30.024779, longitude: -51.182953),
                         isOpenNow: true,
                         rating: 4.1,
                         photoUrls: [],
                         distance: 0.0,
                         formattedDistance: ""),
        MockedPlaceModel(id: "place3",
                         name: "Place 3",
                         coordinate: Coordinate(latitude: -30.023460, longitude: -51.183779),
                         isOpenNow: false,
                         rating: 4.8,
                         photoUrls: [
                            URL(string: "https://media-cdn.tripadvisor.com/media/photo-m/1280/16/ea/16/6f/french-23-musujacy-z.jpg")!
            ],
                         distance: 0.0,
                         formattedDistance: ""),
        MockedPlaceModel(id: "place4",
                         name: "Place 4 with amazingly long name for whatever reason",
                         coordinate: Coordinate(latitude: -30.024679, longitude: -51.182153),
                         isOpenNow: true,
                         rating: 2.2,
                         photoUrls: [],
                         distance: 0.0,
                         formattedDistance: ""),
    ]
    
    private let reviews: [PlaceID: [AbstractReview]] = [
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            callback?(self.places, nil)
        }
    }
    
    
    func fetchReviews(for place: AbstractPlace, callback: FetchReviewsCallback?) {
        let reviews = self.reviews[place.id] ?? []
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            callback?(reviews, nil)
        }
    }
}
