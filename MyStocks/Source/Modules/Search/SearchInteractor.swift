//
//  SearchInteractor.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import StockContracts
import Foundation

final class SearchInteractor {
    
    private var searchRequest: URLSessionDataTask?
    private let watchlistKey = "kWatchListArray"
    
    weak var presenter: SearchIToPInterface?
}

// MARK: - Extensions -

extension SearchInteractor: SearchInteractorInterface {
    
    func saveSymbolToWatchlist(symbol: StockSymbol) {
        
        guard let symbolData = try? symbol.serializedData() else {
            self.presenter?.didSave(symbol: symbol, success: false)
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
        
        self.presenter?.didSave(symbol: symbol, success: true)
    }
    
    func searchStocks(forQuery query: String) -> Void {
        searchRequest?.cancel()
        if query.count > 2 {
            self.presenter?.findingSymbols(for: query)
            let params: JSON = [
                "keyword": query
            ]
            
            self.searchRequest = WebClient().load(endpoint: Endpoint.symbolSearch, method: .get, params: params) { (data, error) in
                var symbols : [StockSymbol]
                defer {
                    self.presenter?.didFind(symbols: symbols)
                }
                
                if let data = data, let searchResponse = try? SymbolSearchResponse(serializedData: data) {
                    symbols = searchResponse.symbols
                } else {
                    symbols = []
                }
            }
        } else {
            self.presenter?.didFind(symbols: [])
        }
    }
}
