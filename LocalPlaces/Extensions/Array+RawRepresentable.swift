//
//  Array+RawRepresentable.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation

extension Array where Element: RawRepresentable, Element.RawValue: Comparable {
    
    func sortedByAscendingRawValue() -> Self {
        return self.sorted { (filter1, filter2) -> Bool in
            filter1.rawValue < filter2.rawValue
        }
    }
    
}
