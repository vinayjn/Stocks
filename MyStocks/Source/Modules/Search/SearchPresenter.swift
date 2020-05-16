//
//  SearchPresenter.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import Contracts
import Foundation

final class SearchPresenter {

    // MARK: - Private properties -
    private var symbols: [StockSymbol] = []
    
    private lazy var mainQueue = DispatchQueue.main
    private lazy var utilityQueue = DispatchQueue.global(qos: .utility)
    
    private unowned let view: SearchViewInterface
    private let interactor: SearchInteractorInterface
    private let wireframe: SearchWireframeInterface

    // MARK: - Lifecycle -

    init(view: SearchViewInterface, interactor: SearchInteractorInterface, wireframe: SearchWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension SearchPresenter: SearchPresenterInterface {
    
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
        self.interactor.searchStocks(forQuery: query)
    }
    
    func selectedSymbolAt(index: Int) {
        let symbol = self.symbols[index]
        self.interactor.saveSymbolToWatchlist(symbol: symbol)
    }
}

extension SearchPresenter: SearchIToPInterface {
    
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
