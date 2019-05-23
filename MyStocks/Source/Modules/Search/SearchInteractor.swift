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
        let params: [String: Any] = [
            "function": Function.symbolSearch.rawValue,
            "keywords": query
        ]
        DispatchQueue.global().async { [weak self] in
            self?.searchRequest = WebClient().load(method: .get, params: params) { (data, error) in
                if let data = data, let searchResponse = try? SymbolSearchResponse(jsonUTF8Data: data) {
                    DispatchQueue.main.async {
                        self?.presenter.didFind(symbols: searchResponse.symbols)
                    }                    
                }
            }
        }        
    }
}
