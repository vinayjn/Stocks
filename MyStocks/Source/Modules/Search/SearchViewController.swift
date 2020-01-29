//
//  SearchViewController.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import UIKit
import SVProgressHUD
import Contracts

protocol ActivityViewProtocol: class {
    func showActivity() -> Void
    func hideActivity() -> Void
}

extension ActivityViewProtocol {
    
    func showAlert(success: Bool, message: String) -> Void {
        if success {
            SVProgressHUD.showSuccess(withStatus: message)
        } else {
            SVProgressHUD.showError(withStatus: message)
        }
    }
    
    func showActivity() -> Void {
        SVProgressHUD.show()
    }
    func hideActivity() -> Void {
        SVProgressHUD.dismiss()
    }
}

protocol SearchViewProtocol: ActivityViewProtocol {
    func updateList() -> Void
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    private let cellReuseId = "Cell"
    
    var presenter: SearchPresenterProtocol!
    
    init() {
        super.init(nibName: "SearchViewController", bundle: Bundle.resourceBundle())
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: self, interactor: interactor)
        interactor.presenter = presenter
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension SearchViewController: SearchViewProtocol {
    
    func updateList() {
        reloadList()
    }
}
