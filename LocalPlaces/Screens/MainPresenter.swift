//
//  MainPresenter.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

class MainPresenter: AbstractMainPresenter {
    
    @Injected var view: AbstractMainView
    @Injected private var placesService: AbstractPlacesService
    @Injected private var locationService: AbstractLocationService
    
    private var places: [AbstractPlace] = []
    
    init() {
        view.showInitialLoadIndicator()
        locationService.fetch { [weak self] (coordinate) in
            if let coordinate = coordinate {
                self?.locationUpdated(coordinate)
            }
        }
    }
    
    private func locationUpdated(_ coordinate: Coordinate) {
        
        placesService.fetchNear(coordinate: coordinate) { [weak self] (places, message) in
            guard let self = self else { return }
            
            self.view.hideInitialLoadIndicator()
            
            if let places = places {
                self.places = places
                self.updateList()
            } else if let message = message {
                self.view.show(errorMessage: message)
            }
            
        }
        
    }
    
    private func updateList() {
        view.show(places: places)
    }
}
