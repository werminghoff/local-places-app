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
    private var lastKnownCoordinate: Coordinate?
    
    private var places: [AbstractPlace] = []
    
    init() {
        view.presenter = self
        view.loadViewIfNeeded()
        view.showLoadingIndicator()
        locationService.fetch { [weak self] (coordinate) in
            if let coordinate = coordinate {
                self?.lastKnownCoordinate = coordinate
                self?.fetchPlacesNear(coordinate)
            }
        }
    }
    
    private func fetchPlacesNear(_ coordinate: Coordinate) {
        
        placesService.fetchNear(coordinate: coordinate) { [weak self] (places, message) in
            guard let self = self else { return }
            
            self.view.hideLoadingIndicator()
            
            if let places = places {
                self.places = places.sortedByRating()
                self.updateList()
            } else if let message = message {
                self.view.show(errorMessage: message)
            }
            
        }
        
    }
    
    func refreshPlacesList() {
        if let coordinate = lastKnownCoordinate {
            view.showLoadingIndicator()
            fetchPlacesNear(coordinate)
        }
    }
    
    private func updateList() {
        view.show(places: places)
    }
}
