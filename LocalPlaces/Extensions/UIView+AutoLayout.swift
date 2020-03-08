//
//  UIView+AutoLayout.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

extension UIView {
    
    static func autoLayout() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    @discardableResult
    func autoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
}
