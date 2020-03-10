//
//  Array+AbstractPlace.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

extension Array where Element == AbstractPlace {
    
    func sortedByHigherRating() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            (place1.rating ?? Double.leastNonzeroMagnitude) > (place2.rating ?? Double.leastNonzeroMagnitude)
        }
    }
    
    func sortedByLowerRating() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            (place1.rating ?? Double.greatestFiniteMagnitude) < (place2.rating ?? Double.greatestFiniteMagnitude)
        }
    }
 
    func sortedByNameAscending() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            place1.name.compare(place2.name) == .orderedAscending
        }
    }
    
    func sortedByNameDescending() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            place1.name.compare(place2.name) == .orderedDescending
        }
    }
    
    func sortedByHigherDistance(to coordinate: Coordinate) -> Self {
        return self.sorted { (place1, place2) -> Bool in
            place1.coordinate.distance(to: coordinate) > place2.coordinate.distance(to: coordinate)
        }
    }
    
    func sortedByLowerDistance(to coordinate: Coordinate) -> Self {
        return self.sorted { (place1, place2) -> Bool in
            place1.coordinate.distance(to: coordinate) < place2.coordinate.distance(to: coordinate)
        }
    }
    
    func sortedByOpenPlaces() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            place1.isOpenNow == true && place2.isOpenNow != true
        }
    }
    
    func sortedByClosedPlaces() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            place1.isOpenNow == false && place2.isOpenNow != false
        }
    }
    
}
