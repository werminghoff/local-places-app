//
//  AppCoordinator.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import UIKit

protocol AbstractAppCoordinator: class {
    var rootViewController: UIViewController { get }
    var mainPresenter: AbstractMainPresenter { get }
    var sortingTypePicker: AbstractSortingTypePicker { get }
    var filterTypePicker: AbstractFilterTypePicker { get }
    var detailPresenter: AbstractDetailPresenter { get }
}

class AppCoordinator: AbstractAppCoordinator {
    
    lazy private(set) var rootViewController: UIViewController = UINavigationController(rootViewController: self.mainPresenter.view as! UIViewController)
    @Injected var mainPresenter: AbstractMainPresenter
    @Injected var sortingTypePicker: AbstractSortingTypePicker
    @Injected var filterTypePicker: AbstractFilterTypePicker
    @Injected var detailPresenter: AbstractDetailPresenter
    
    init() {
        mainPresenter.set(delegate: self)
    }
    
}

// MARK: - AbstractMainViewDelegate
extension AppCoordinator: AbstractMainViewDelegate {
    
    func mainViewSelected(_ place: AbstractPlace) {
        detailPresenter.set(place: place)
        rootViewController.show(detailPresenter.view as! UIViewController, sender: nil)
    }
    
    func mainViewSelectFilters(with currentFilters: [FilterType]?, _ callback: @escaping (([FilterType])-> Void)) {
        filterTypePicker.callback = { [weak self] (types) in
            callback(types)
            self?.rootViewController.dismiss(animated: true, completion: nil)
        }
        filterTypePicker.selectedValues = Set<FilterType>(currentFilters ?? [])
        let navController = UINavigationController(rootViewController: filterTypePicker as! UIViewController)
        rootViewController.present(navController, animated: true, completion: nil)
    }
    
    func mainViewSelectSorting(with currentSorting: SortingType?, _ callback: @escaping ((SortingType)-> Void)) {
        sortingTypePicker.callback = { [weak self] (type) in
            callback(type)
            self?.rootViewController.dismiss(animated: true, completion: nil)
        }
        sortingTypePicker.selectedValue = currentSorting
        
        let navController = UINavigationController(rootViewController: sortingTypePicker as! UIViewController)
        rootViewController.present(navController, animated: true, completion: nil)
    }
}
