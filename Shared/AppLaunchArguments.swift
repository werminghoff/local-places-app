//
//  AppLaunchArguments.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 10/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

enum AppLaunchArguments: String {
    case noLayerAnimations
    case noViewAnimations
    case withDelayedServices
    
    case withMocks
    case withMocksFailingLocation
    case withMocksFailingFetchNearby
    case withMocksFailingFetchPhoto
    case withMocksFailingFetchReviews
    
    case setLocale = "-AppleLocale"
    case locale_BR = "pt_BR"
    case locale_US = "en_US"
}
