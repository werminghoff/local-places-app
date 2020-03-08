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
}

protocol AbstractMainView: class {
    var presenter: AbstractMainPresenter? { get set }
    func show(places: [AbstractPlace])
    func show(errorMessage: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func setDelegate(_ delegate: AbstractMainViewDelegate)
    func loadViewIfNeeded()
}

protocol AbstractMainPresenter: class {
    var view: AbstractMainView { get }
    
    func refreshPlacesList()
}
