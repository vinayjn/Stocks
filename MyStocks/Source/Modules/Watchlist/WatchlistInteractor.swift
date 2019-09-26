//
//  WatchlistInteractor.swift
//  Project: MyStocks
//
//  Module: Watchlist
//
//  By Vinay Jain 26/09/19
//  Vinay Jain 2019
//

// MARK: Imports

import Foundation
import Contracts
// MARK: Protocols

/// Should be conformed to by the `WatchlistInteractor` and referenced by `WatchlistPresenter`
protocol WatchlistPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func fetchStoredWatchlist()
}

// MARK: -

/// The Interactor for the Watchlist module
final class WatchlistInteractor: WatchlistPresenterInteractorProtocol {
    
    private let watchlistkey = "kWatchListArray"
    
	// MARK: - Variables

	weak var presenter: WatchlistInteractorPresenterProtocol?

	// MARK: - Watchlist Presenter to Interactor Protocol

    func fetchStoredWatchlist() {
        let defaults = UserDefaults.standard
        
        guard let dataList = defaults.array(forKey: watchlistkey) as? [Data] else {
            self.presenter?.didFetchWatchlist(watchlist: nil, success: false)
            return
        }
        
        let watchlist = dataList.compactMap {
            return try? StockSymbol(serializedData: $0)
        }
        self.presenter?.didFetchWatchlist(watchlist: watchlist, success: true)
    }
}
