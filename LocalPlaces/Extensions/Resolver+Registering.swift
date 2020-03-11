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
        
        if CommandLine.arguments.contains(AppLaunchArguments.withMocks.rawValue) {
            
            var delay: Double? = nil
            if CommandLine.arguments.contains(AppLaunchArguments.withDelayedServices.rawValue) {
                delay = 2.0
            }
            
            var fetchLocationError: String?
            var fetchNearbyError: String?
            var fetchPhotoError: String?
            var fetchReviewsError: String?
            
            if CommandLine.arguments.contains(AppLaunchArguments.withMocksFailingLocation.rawValue) {
                fetchLocationError = "Error while getting user's location"
            }
            
            if CommandLine.arguments.contains(AppLaunchArguments.withMocksFailingFetchPhoto.rawValue) {
                fetchPhotoError = "Error while fetching photo"
            }
            
            if CommandLine.arguments.contains(AppLaunchArguments.withMocksFailingFetchNearby.rawValue) {
                fetchNearbyError = "Error while fetching nearby places"
            }
            
            if CommandLine.arguments.contains(AppLaunchArguments.withMocksFailingFetchReviews.rawValue) {
                fetchReviewsError = "Error while fetching reviews"
            }
            
            if let fetchLocationError = fetchLocationError {
                register { MockedFailableLocationService(delay: delay, fetchError: fetchLocationError) as AbstractLocationService }
            } else {
                register { MockedSuccessfulLocationService(delay: delay) as AbstractLocationService }
            }
            
            if fetchNearbyError != nil || fetchPhotoError != nil || fetchReviewsError != nil {
                register { MockedFailablePlacesService(fetchNearError: fetchNearbyError, fetchPhotoError: fetchPhotoError, fetchReviewsError: fetchReviewsError) as AbstractPlacesService }
            } else {
                register { MockedSuccessfulPlacesService() as AbstractPlacesService }
            }
            
        } else {
            
            register { GooglePlacesAPIService() as AbstractPlacesService }
            register { CoreLocationService() as AbstractLocationService }
            
        }
    }
    
    private static func registerCoordinators() {
        register { AppCoordinator() as AbstractAppCoordinator }
    }
    
}
