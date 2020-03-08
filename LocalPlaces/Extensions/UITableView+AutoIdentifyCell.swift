//
//  UITableView+AutoIdentifyCell.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<CellType: UITableViewCell>(_ type: CellType.Type) {
        register(CellType.self, forCellReuseIdentifier: CellType.defaultIdentifier)
    }
    
    func dequeueReusableCell<CellType: UITableViewCell>(_ type: CellType.Type, for indexPath: IndexPath) -> CellType {
        return dequeueReusableCell(withIdentifier: CellType.defaultIdentifier,
                                   for: indexPath) as! CellType
    }
    
}
