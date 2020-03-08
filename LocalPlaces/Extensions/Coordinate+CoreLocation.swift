//
//  Coordinate+CoreLocation.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import CoreLocation

extension Coordinate {
    
    func distance(to other: Coordinate) -> Double {
        let thisLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let otherLocation = CLLocation(latitude: other.latitude, longitude: other.longitude)
        return thisLocation.distance(from: otherLocation)
    }
    
    func formattedDistance(using locale: Locale = .current, to other: Coordinate) -> String {
        let distance = self.distance(to: other)
        
        let formatter = MeasurementFormatter()
        formatter.locale = locale
        formatter.unitStyle = .short
        
        let unit = Measurement(value: distance, unit: UnitLength.meters)
        return formatter.string(from: unit)
        
    }
    
}
