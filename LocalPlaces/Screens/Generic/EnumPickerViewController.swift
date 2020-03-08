//
//  EnumPickerViewController.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 08/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

/**
 Base/generic implementation for a UIViewController to pick a value from an enum type
 */
class BaseEnumPickerViewController<EnumType: SelectableEnumerator>: UITableViewController {
    
    fileprivate let options: [EnumType] = EnumType.allCases.map({ $0 }).sortedByAscendingRawValue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = options[indexPath.row].getName()
        return cell
    }
    
}

/**
 Single-selection variation of BaseEnumPickerViewController
 */
class SingleEnumPickerViewController<EnumType: SelectableEnumerator>: BaseEnumPickerViewController<EnumType> {
    
    var callback: ((EnumType) -> Void)?
    var selectedValue: EnumType? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callback?(options[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let selectedValue = selectedValue, selectedValue == options[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

/**
 Multiple-selection variation of BaseEnumPickerViewController
 */
class MultipleEnumPickerViewController<EnumType: SelectableEnumerator>: BaseEnumPickerViewController<EnumType> {
    
    var callback: (([EnumType]) -> Void)?
    var selectedValues = Set<EnumType>() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.cancel(target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem.save(target: self, action: #selector(save))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let value = options[indexPath.row]
        if selectedValues.contains(value) {
            selectedValues.remove(value)
        } else {
            selectedValues.insert(value)
        }
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let value = options[indexPath.row]
        if selectedValues.contains(value) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func save() {
        let selected: [EnumType] = selectedValues.map({ $0 })
        callback?(selected)
        dismiss(animated: true, completion: nil)
    }

}
