//
//  MainViewContract.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

protocol AbstractMainViewDelegate: class {
    func mainViewSelected(_ place: AbstractPlace)
    func mainViewSelectFilters(_ callback: @escaping (([FilterType])-> Void))
    func mainViewSelectSorting(_ callback: @escaping ((SortingType)-> Void))
}

protocol AbstractMainView: class {
    var presenter: AbstractMainPresenter? { get set }
    func show(places: [AbstractPlace])
    func show(errorMessage: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func set(delegate: AbstractMainViewDelegate?)
    func loadViewIfNeeded()
}

protocol AbstractMainPresenter: class {
    var view: AbstractMainView { get }
    
    func refreshPlacesList()
    func set(filters: [FilterType])
    func set(sorting: SortingType)
}
