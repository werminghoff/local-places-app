//
//  CoreLocationService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationService: NSObject, AbstractLocationService {
    
    private let locationManager = CLLocationManager()
    private var callback: LocationUpdatedCallback?
    
    func fetch(_ callback: @escaping LocationUpdatedCallback) {
        
        guard CLLocationManager.locationServicesEnabled() == true else {
            callback(nil, "Location Services disabled")
            return
        }
        
        self.callback = callback
        locationManager.delegate = self
        locationManager.requestLocation()
    
    }
    
}

extension CoreLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first,
            let callback = self.callback {
            
            let coordinate = Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            callback(coordinate, nil)
            
            self.callback = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let callback = self.callback {
            callback(nil, error.localizedDescription)
            
            self.callback = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            self.callback?(nil, "You need to provide permission for the app to use Location Services")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            preconditionFailure("[\(#file).\(#function)] Unhandled CLLocationManager.authorizationStatus() -> \(CLLocationManager.authorizationStatus())")
        }
        
    }
    
}
