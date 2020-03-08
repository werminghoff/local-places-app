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
        registerServices()
    }
    
    private static func registerViews() {
        register { MainViewController() as AbstractMainView }
        register { MainPresenter() as AbstractMainPresenter }
        
        register { SortingTypePickerViewController() as AbstractSortingTypePicker}
        register { FilterTypePickerViewController() as AbstractFilterTypePicker}
    }
    
    private static func registerServices() {
        register { MockedPlacesService() as AbstractPlacesService }
        register { MockedLocationService() as AbstractLocationService }
    }
}
