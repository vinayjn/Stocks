//
//  WatchlistInterfaces.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import Contracts
import UIKit

protocol WatchlistWireframeInterface: WireframeInterface {
    func openSearch()
}

protocol WatchlistViewInterface: ViewInterface {
    func updateWatchList()
}

protocol WatchlistPresenterInterface: PresenterInterface {
    func viewDidLoad()
    var numberOfRows: Int { get }
    func titleFor(index: Int) -> String
    func descriptionFor(index: Int) -> String
    func didTapAddButton()
}

protocol WatchlistInteractorInterface: InteractorInterface {
    func fetchStoredWatchlist()
}

protocol WatchlistIToPInterface: class {
    
    func didFetchWatchlist(watchlist: [StockSymbol]?, success: Bool) -> Void
}
