//
//  MainViewController.swift
//  LocalPlaces
//
//  Created by Bruno Rigo Werminghoff on 07/03/20.
//  Copyright © 2020 Bruno Rigo Werminghoff. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var presenter: AbstractMainPresenter?
    
    private let refreshControl = UIRefreshControl()
    private weak var delegate: AbstractMainViewDelegate?
    private let tableView = UITableView.autoLayout()
    private var places: [AbstractPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PlaceTableViewCell.self)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNearbyPlaces), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.filter(target: self, action: #selector(showFilterOptions))
        navigationItem.leftBarButtonItem = UIBarButtonItem.sorting(target: self, action: #selector(showSortingOptions))
        
        title = "Local Places"
    }
    
    private func setupConstraints() {
        view.addConstraints([
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    @objc private func refreshNearbyPlaces() {
        presenter?.refreshPlacesList()
    }
    
    @objc private func showSortingOptions() {
        delegate?.mainViewSelectSorting({ [weak self] (type) in
            self?.presenter?.set(sorting: type)
        })
    }
    
    @objc private func showFilterOptions() {
        delegate?.mainViewSelectFilters({ [weak self] (types) in
            self?.presenter?.set(filters: types)
        })
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
    
    func showLoadingIndicator() {
        // FIXME: spinner doesn't animate if UIViewController doesn't have a UIWindow yet, on iOS < 13.0
        self.refreshControl.beginRefreshing()
    }
    
    func hideLoadingIndicator() {
        refreshControl.endRefreshing()
    }
 
    func set(delegate: AbstractMainViewDelegate?) {
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
        let cell = tableView.dequeueReusableCell(PlaceTableViewCell.self, for: indexPath)
        cell.place = places[indexPath.row]
        return cell
    }
        
}
