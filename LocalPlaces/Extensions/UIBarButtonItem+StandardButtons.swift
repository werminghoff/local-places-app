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
        return UIBarButtonItem(barButtonSystemItem: .cancel, target: target, action: action)
    }
    
    static func save(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .save, target: target, action: action)
    }
    
    static func filter(target: Any?, action: Selector?) -> UIBarButtonItem {
        let icon = #imageLiteral(resourceName: "icon_filter")
        return UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
    }
    
    static func sorting(target: Any?, action: Selector?) -> UIBarButtonItem {
        let icon = #imageLiteral(resourceName: "icon_sorting")
        return UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
    }
    
}
