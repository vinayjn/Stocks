//
//  WatchlistInteractor.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import StockContracts
import Foundation

final class WatchlistInteractor {
    
    private let watchlistkey = "kWatchListArray"
    weak var presenter: WatchlistIToPInterface?
    
    private func getQuote(forSymbol symbol: String) -> Void {
                
        let params: JSON = ["symbol": symbol]
        _ = WebClient().load(endpoint: Endpoint.symbolQuote, method: .get, params: params) { (data, error) in
            let quote: StockQuote?
            if let data = data, let response = try? StockQuoteResponse(serializedData: data) {
                quote = response.quote
            } else {
                quote = nil
            }
        }
    }
}

// MARK: - Extensions -

extension WatchlistInteractor: WatchlistInteractorInterface {
    
    func fetchStoredWatchlist() {
        let defaults = UserDefaults.standard
        
        guard let dataList = defaults.array(forKey: watchlistkey) as? [Data] else {
            self.presenter?.didFetchWatchlist(watchlist: nil, success: false)
            return
        }
        
        let watchlist = dataList.compactMap {
            return try? StockSymbol(serializedData: $0)
        }
        
        self.getQuote(forSymbol: watchlist.first!.symbol)
        
        
        self.presenter?.didFetchWatchlist(watchlist: watchlist, success: true)
    }
}
