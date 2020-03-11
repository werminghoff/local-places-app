//
//  FilterTypePickerViewController.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import Foundation
import UIKit

class FilterTypePickerViewController: MultipleEnumPickerViewController<FilterType>, AbstractFilterTypePicker {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.accessibilityIdentifier = Accessibility.filterTypeLabel(indexPath.row).identifier
        if cell.accessoryType == .checkmark {
            cell.accessibilityValue = Accessibility.statusChecked
        } else {
            cell.accessibilityValue = Accessibility.statusNone
        }
        return cell
    }
    
}
