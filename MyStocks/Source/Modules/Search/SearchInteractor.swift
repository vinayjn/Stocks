//
//  SearchInteractor.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import Foundation
import Contracts

protocol SearchInteractorProtocol {
    
    func searchStocks(forQuery query: String) -> Void
    func saveSymbolToWatchlist(symbol: StockSymbol) -> Void
}


class SearchInteractor: SearchInteractorProtocol {
    
    private var searchRequest: URLSessionDataTask?
    
    private let watchlistKey = "kWatchListArray"
    
    var presenter: SearchPresenterInteractorCallbacks!
    
    func saveSymbolToWatchlist(symbol: StockSymbol) {
        
        guard let symbolData = try? symbol.serializedData() else {
            presenter.didSave(symbol: symbol, success: false)
            return
        }
        
        let defaults = UserDefaults.standard
        var watchList: [Data]
        if let storedList  = defaults.array(forKey: watchlistKey) as? [Data] {
            watchList = storedList
            watchList.append(symbolData)
        } else {
            watchList = [symbolData]
        }
        defaults.set(watchList, forKey: watchlistKey)
        defaults.synchronize()
        
        presenter.didSave(symbol: symbol, success: true)
    }
    
    func searchStocks(forQuery query: String) -> Void {
        searchRequest?.cancel()
        if query.count > 2 {
            presenter.findingSymbols(for: query)
            let params: [String: Any] = [
                "keyword": query
            ]
            
            self.searchRequest = WebClient().load(endpoint: Endpoint.symbolSearch, method: .get, params: params) { (data, error) in
                var symbols : [StockSymbol]
                defer {
                    self.presenter.didFind(symbols: symbols)
                }
                
                if let data = data, let searchResponse = try? SymbolSearchResponse(serializedData: data) {
                    symbols = searchResponse.symbols
                } else {
                    symbols = []
                }
            }
        } else {
            presenter.didFind(symbols: [])
        }
    }
}
