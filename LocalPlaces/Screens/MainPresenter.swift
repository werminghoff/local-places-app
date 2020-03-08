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
    private var filters: [FilterType] = []
    private var sorting: SortingType = .ratingHigher
    
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
            
            if let message = message {
                self.view.show(errorMessage: message)
            } else {
                self.places = places ?? []
                self.updateDistances()
                self.updateList()
            }
        }
        
    }
    
    func refreshPlacesList() {
        if let coordinate = lastKnownCoordinate {
            view.showLoadingIndicator()
            fetchPlacesNear(coordinate)
        }
    }
    
    func set(sorting: SortingType) {
        self.sorting = sorting
        updateList()
    }
    
    func set(filters: [FilterType]) {
        self.filters = filters
        updateList()
    }
    
    private func updateDistances() {
        if let lastKnownCoordinate = self.lastKnownCoordinate {
            for idx in places.indices {
                places[idx].distance = places[idx].coordinate.distance(to: lastKnownCoordinate)
                places[idx].formattedDistance = places[idx].coordinate.formattedDistance(to: lastKnownCoordinate)
            }
        }
    }
    
    private func updateList() {
        var placesToShow = places
        
        // Apply filtering, if there is one selected
        for filter in self.filters {
            switch filter {
            case .withRating:
                placesToShow = placesToShow.filter({ $0.rating != nil })
            case .withoutRating:
                placesToShow = placesToShow.filter({ $0.rating == nil })
            case .open:
                placesToShow = placesToShow.filter({ $0.isOpenNow == true })
            case .closed:
                placesToShow = placesToShow.filter({ $0.isOpenNow == false })
            }
        }
        
        // Apply sorting
        switch sorting {
        case .nameAscending:
            placesToShow = placesToShow.sortedByNameAscending()
        case .nameDescending:
            placesToShow = placesToShow.sortedByNameDescending()
        case .ratingHigher:
            placesToShow = placesToShow.sortedByHigherRating()
        case .ratingLower:
            placesToShow = placesToShow.sortedByLowerRating()
        case .distanceLower:
            if let coordinate = lastKnownCoordinate {
                placesToShow = placesToShow.sortedByLowerDistance(to: coordinate)
            }
        case .distanceHigher:
            if let coordinate = lastKnownCoordinate {
                placesToShow = placesToShow.sortedByHigherDistance(to: coordinate)
            }
        case .open:
            placesToShow = placesToShow.sortedByOpenPlaces()
        case .closed:
            placesToShow = placesToShow.sortedByClosedPlaces()
        }
        
        view.show(places: placesToShow)
    }
}
