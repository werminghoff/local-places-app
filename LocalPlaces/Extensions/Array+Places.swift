//
//  Array+Places.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

extension Array where Element == AbstractPlace {
    
    func sortedByRating() -> Self {
        return self.sorted { (place1, place2) -> Bool in
            (place1.rating ?? 0.0) > (place2.rating ?? 0.0)
        }
    }
    
}
