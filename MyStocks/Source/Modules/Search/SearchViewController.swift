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

protocol ActivityViewProtocol {
    func showActivity() -> Void
    func hideActivity() -> Void
}

extension ActivityViewProtocol {
    
    func showActivity() -> Void {
        SVProgressHUD.show()
    }
    func hideActivity() -> Void {
        SVProgressHUD.dismiss()
    }
}

protocol SearchViewProtocol: ActivityViewProtocol {
    func updateList(with symbols: [StockSymbol]) -> Void
    
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var symbols: [StockSymbol] = []
    
    var presenter: SearchPresenterProtocol!
    
    init() {
        super.init(nibName: "SearchViewController", bundle: Bundle.main)
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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func reloadList() -> Void {
        table.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.symbols[indexPath.row].name
        return cell
    }            
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.searchSymbols(for: searchText)
    }
}

extension SearchViewController: SearchViewProtocol {
    
    func updateList(with symbols: [StockSymbol]) {
        self.symbols = symbols
        reloadList()
    }
}
