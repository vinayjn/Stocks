//
//  SearchInterfaces.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import StockContracts
import UIKit

protocol SearchWireframeInterface: WireframeInterface {
}

protocol SearchViewInterface: ViewInterface {
    func updateList()
}

protocol SearchPresenterInterface: PresenterInterface {
    
    var numberOfRows: Int { get }
    func titleFor(index: Int) -> String
    func descriptionFor(index: Int) -> String
    func searchSymbols(for query: String) -> Void
    func selectedSymbolAt(index: Int) -> Void
    
}

protocol SearchInteractorInterface: InteractorInterface {
    
    func searchStocks(forQuery query: String) -> Void
    func saveSymbolToWatchlist(symbol: StockSymbol) -> Void
}

protocol SearchIToPInterface: class {
    
    func didFind(symbols: [StockSymbol])
    func findingSymbols(for query: String)
    func didSave(symbol: StockSymbol, success: Bool)
}
