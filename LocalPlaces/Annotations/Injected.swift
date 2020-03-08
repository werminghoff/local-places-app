//
//  Injected.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import Resolver

/**
 PropertyWrapper used to hide the underlying dependency injection system
 */
@propertyWrapper
struct Injected<T> {
    var wrappedValue: T
    
    init() {
        wrappedValue = Resolver.resolve()
    }
}
