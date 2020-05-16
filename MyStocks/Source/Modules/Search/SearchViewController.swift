//
//  SearchViewController.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - Private properties -

    @IBOutlet private weak var table: UITableView!
    
    private let cellReuseId = "Cell"
    
    var presenter: SearchPresenterInterface!

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        let searchController  = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func reloadList() -> Void {
        table.reloadData()
    }
    
}

// MARK: - Extensions -

extension SearchViewController: SearchViewInterface {
    func updateList() {
        reloadList()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellReuseId) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseId)
        }
        
        cell.textLabel?.text = self.presenter.titleFor(index: indexPath.row)
        cell.detailTextLabel?.text = self.presenter.descriptionFor(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.selectedSymbolAt(index: indexPath.row)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.presenter.searchSymbols(for: text)
        }
    }
}
