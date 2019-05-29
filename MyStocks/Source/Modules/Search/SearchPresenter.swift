//
//  SearchPresenter.swift
//  MyStocks
//
//  Created by Vinay Jain on 18/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import UIKit

protocol SearchPresenterProtocol {
    func searchSymbols(for query: String) -> Void
}

protocol SearchPresenterInteractorCallbacks {
    
    func didFind(symbols: [StockSymbol])
    func findingSymbols(for query: String)
}

class SearchPresenter: SearchPresenterProtocol {
    
    let view: SearchViewProtocol
    let interactor: SearchInteractorProtocol
    
    init(view: SearchViewProtocol, interactor: SearchInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func searchSymbols(for query: String) {        
        self.interactor.searchStocks(forQuery: query)
    }
}

extension SearchPresenter: SearchPresenterInteractorCallbacks {
    
    func didFind(symbols: [StockSymbol]) {
        self.view.updateList(with: symbols)
        self.view.hideActivity()
    }
    
    func findingSymbols(for query: String) {
        self.view.showActivity()
    }
}
