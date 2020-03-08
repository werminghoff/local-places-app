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
    
    init() {
        mainPresenter.view.setDelegate(self)
    }
    
}

extension AppCoordinator: AbstractMainViewDelegate {
    
    func mainViewSelected(_ place: AbstractPlace) {
        print("Selected: \(place.name)")
    }
    
}
