//
//  SearchInteractor.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import Foundation
import SwiftProtobuf

protocol SearchInteractorProtocol {
    
    func searchStocks(forQuery query: String) -> Void
}


class SearchInteractor: SearchInteractorProtocol {
    
    private var searchRequest: URLSessionDataTask?
    
    var presenter: SearchPresenterInteractorCallbacks!
    
    func searchStocks(forQuery query: String) -> Void {
        searchRequest?.cancel()
        if query.count > 2 {
            presenter.findingSymbols(for: query)
            let params: [String: Any] = [
                "keyword": query
            ]
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.searchRequest = WebClient().load(endpoint: Endpoint.symbolSearch, method: .get, params: params) { (data, error) in
                    var symbols : [StockSymbol]
                    
                    defer {
                        DispatchQueue.main.async {
                            self?.presenter.didFind(symbols: symbols)
                        }
                    }
                    
                    if let data = data, let searchResponse = try? SymbolSearchResponse(serializedData: data) {
                        symbols = searchResponse.symbols
                    } else {
                        symbols = []
                    }
                }
            }
        } else {
            presenter.didFind(symbols: [])
        }
    }
}
