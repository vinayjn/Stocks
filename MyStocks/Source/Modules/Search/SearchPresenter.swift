//
//  SearchPresenter.swift
//  MyStocks
//
//  Created by Vinay Jain on 18/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import UIKit
import Contracts

protocol SearchPresenterProtocol {
    var numberOfRows: Int { get }
    
    func titleFor(index: Int) -> String
    func descriptionFor(index: Int) -> String
    func searchSymbols(for query: String) -> Void
    func selectedSymbolAt(index: Int) -> Void
    
}

protocol SearchPresenterInteractorCallbacks {
    
    func didFind(symbols: [StockSymbol])
    func findingSymbols(for query: String)
    func didSave(symbol: StockSymbol, success: Bool)
}

class SearchPresenter: SearchPresenterProtocol {
    
    let view: SearchViewProtocol
    let interactor: SearchInteractorProtocol
    
    private lazy var mainQueue = DispatchQueue.main
    private lazy var utilityQueue = DispatchQueue.global(qos: .utility)
    
    private var symbols: [StockSymbol] = []
    
    init(view: SearchViewProtocol, interactor: SearchInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    var numberOfRows: Int {
        return self.symbols.count
    }
    
    func titleFor(index: Int) -> String {
        return self.symbols[index].symbol
    }
    
    func descriptionFor(index: Int) -> String {
        return self.symbols[index].name
    }
                
    func searchSymbols(for query: String) {        
        utilityQueue.async { [weak self] in
            self?.interactor.searchStocks(forQuery: query)
        }
        
    }
    
    func selectedSymbolAt(index: Int) {
        utilityQueue.async {[weak self] in
            if let symbol = self?.symbols[index] {
                self?.interactor.saveSymbolToWatchlist(symbol: symbol)
            } else {
                self?.mainQueue.async {
                    self?.view.showAlert(success: false, message: "Something went Wrong!")
                }
            }                        
        }
    }
}

extension SearchPresenter: SearchPresenterInteractorCallbacks {
    
    func didFind(symbols: [StockSymbol]) {
        mainQueue.async { [weak self] in
            self?.symbols = symbols
            self?.view.updateList()
            self?.view.hideActivity()
        }
    }
    
    func findingSymbols(for query: String) {
        mainQueue.async { [weak self] in
            self?.view.showActivity()
        }
    }
    
    func didSave(symbol: StockSymbol, success: Bool) {
        mainQueue.async { [weak self] in
            if success {
                self?.view.showAlert(success: true, message: "\(symbol.name) \n Saved to Watchlist")
            } else {
                self?.view.showAlert(success: false, message: "Couldn't save \n \(symbol.name)")
            }                        
        }
    }
    
}
