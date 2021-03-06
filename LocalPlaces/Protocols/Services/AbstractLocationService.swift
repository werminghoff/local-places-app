//
//  AbstractLocationService.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import CoreLocation

protocol AbstractLocationService: class {
    
    typealias ErrorMessage = String
    typealias LocationUpdatedCallback = ((Coordinate?, ErrorMessage?) -> Void)
    func fetch(_ callback: @escaping LocationUpdatedCallback)
    
}
