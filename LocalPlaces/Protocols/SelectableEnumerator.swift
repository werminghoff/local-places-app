//
//  SelectableEnumerator.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

protocol SelectableEnumerator: RawRepresentable, CaseIterable, Hashable where Self.RawValue: Comparable {
    func getName() -> String
}
