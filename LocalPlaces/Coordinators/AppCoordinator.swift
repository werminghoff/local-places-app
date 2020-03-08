//
//  AppCoordinator.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    lazy private(set) var rootViewController: UIViewController = UINavigationController(rootViewController: self.mainPresenter.view as! UIViewController)
    @Injected private var mainPresenter: AbstractMainPresenter
    @Injected private var sortingTypePicker: AbstractSortingTypePicker
    @Injected private var filterTypePicker: AbstractFilterTypePicker
    @Injected private var detailPresenter: AbstractDetailPresenter
    
    init() {
        mainPresenter.view.set(delegate: self)
    }
    
}

// MARK: - AbstractMainViewDelegate
extension AppCoordinator: AbstractMainViewDelegate {
    
    func mainViewSelected(_ place: AbstractPlace) {
        detailPresenter.set(place: place)
        rootViewController.show(detailPresenter.view as! UIViewController, sender: nil)
    }
    
    func mainViewSelectFilters(_ callback: @escaping (([FilterType])-> Void)) {
        filterTypePicker.callback = { [weak self] (types) in
            callback(types)
            self?.rootViewController.dismiss(animated: true, completion: nil)
        }
        let navController = UINavigationController(rootViewController: filterTypePicker as! UIViewController)
        rootViewController.present(navController, animated: true, completion: nil)
    }
    
    func mainViewSelectSorting(_ callback: @escaping ((SortingType)-> Void)) {
        sortingTypePicker.callback = { [weak self] (type) in
            callback(type)
            self?.rootViewController.dismiss(animated: true, completion: nil)
        }
        sortingTypePicker.selectedValue = nil
        
        let navController = UINavigationController(rootViewController: sortingTypePicker as! UIViewController)
        rootViewController.present(navController, animated: true, completion: nil)
    }
}
