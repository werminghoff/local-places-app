//
//  UIBarButtonItem+StandardButtons.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    static func cancel(target: Any?, action: Selector?) -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: target, action: action)
        button.accessibilityIdentifier = Accessibility.cancelButton.identifier
        return button
    }
    
    static func save(target: Any?, action: Selector?) -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: target, action: action)
        button.accessibilityIdentifier = Accessibility.saveButton.identifier
        return button
    }
    
    static func filter(target: Any?, action: Selector?) -> UIBarButtonItem {
        let icon = #imageLiteral(resourceName: "icon_filter")
        let button = UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
        button.accessibilityIdentifier = Accessibility.filterButton.identifier
        return button
    }
    
    static func sorting(target: Any?, action: Selector?) -> UIBarButtonItem {
        let icon = #imageLiteral(resourceName: "icon_sorting")
        let button = UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
        button.accessibilityIdentifier = Accessibility.sortButton.identifier
        return button
    }
    
}
