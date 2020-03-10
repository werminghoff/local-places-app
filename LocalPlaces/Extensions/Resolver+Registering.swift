//
//  AppDelegate+Resolver.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerViews()
        registerPresenters()
        registerServices()
        registerCoordinators()
    }
    
    private static func registerViews() {
        register { MainViewController() as AbstractMainView }
        register { DetailViewController() as AbstractDetailView }
        register { SortingTypePickerViewController() as AbstractSortingTypePicker}
        register { FilterTypePickerViewController() as AbstractFilterTypePicker}
    }
    
    private static func registerPresenters() {
        register { MainPresenter() as AbstractMainPresenter }
        register { DetailPresenter() as AbstractDetailPresenter }
    }
    
    private static func registerServices() {
        register { GooglePlacesAPIService() as AbstractPlacesService }
        register { CoreLocationService() as AbstractLocationService }   
    }
    
    private static func registerCoordinators() {
        register { AppCoordinator() as AbstractAppCoordinator }
    }
    
}
