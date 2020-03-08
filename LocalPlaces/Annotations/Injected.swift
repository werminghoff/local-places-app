//
//  Injected.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import Resolver

@propertyWrapper
struct Injected<T> {
    var wrappedValue: T
    
    init() {
        wrappedValue = Resolver.resolve()
    }
}
