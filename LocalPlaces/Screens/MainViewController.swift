//
//  MainViewController.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private weak var delegate: AbstractMainViewDelegate?
    private let tableView = UITableView.autoLayout()
    private let activityIndicator = UIActivityIndicatorView.autoLayout()
    private var places: [AbstractPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PlaceTableViewCell.self)
        
        title = "Local Places"
    }
    
    func setupConstraints() {
        view.addConstraints([
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}

// MARK: - AbstractMainView
extension MainViewController: AbstractMainView {
    
    func show(errorMessage: String) {
        let alertController = UIAlertController(title: "Error",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: nil))
        show(alertController, sender: nil)
    }
    
    func show(places: [AbstractPlace]) {
        self.places = places
        tableView.reloadData()
    }
    
    func showInitialLoadIndicator() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func hideInitialLoadIndicator() {
        tableView.isHidden = false
        activityIndicator.stopAnimating()
    }
 
    func setDelegate(_ delegate: AbstractMainViewDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let place = places[indexPath.row]
        delegate?.mainViewSelected(place)
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PlaceTableViewCell.self, for: indexPath)!
        cell.place = places[indexPath.row]
        return cell
    }
        
}
