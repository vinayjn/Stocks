//
//  WatchlistPresenter.swift
//  Project: MyStocks
//
//  Module: Watchlist
//
//  By Vinay Jain 26/09/19
//  Vinay Jain 2019
//

// MARK: Imports

import UIKit
import Contracts

// MARK: Protocols

/// Should be conformed to by the `WatchlistPresenter` and referenced by `WatchlistViewController`
protocol WatchlistViewPresenterProtocol {
	func fetchWatchlist()
    var numberOfRows: Int { get }
    func titleFor(index: Int) -> String
    func descriptionFor(index: Int) -> String
}

/// Should be conformed to by the `WatchlistPresenter` and referenced by `WatchlistInteractor`
protocol WatchlistInteractorPresenterProtocol: class {
	
    
    func didFetchWatchlist(watchlist: [StockSymbol]?, success: Bool) -> Void
}

// MARK: -

/// The Presenter for the Watchlist module
final class WatchlistPresenter: WatchlistViewPresenterProtocol, WatchlistInteractorPresenterProtocol {
    
	// MARK: - Constants

	let router: WatchlistPresenterRouterProtocol
	let interactor: WatchlistPresenterInteractorProtocol

    private lazy var mainQueue = DispatchQueue.main
    private lazy var utilityQueue = DispatchQueue.global(qos: .utility)
	// MARK: Variables
    
    private var watchlist: [StockSymbol] = []
    
	weak var view: WatchlistPresenterViewProtocol?

	// MARK: Inits

	init(router: WatchlistPresenterRouterProtocol, interactor: WatchlistPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
    
    var numberOfRows: Int {
        return self.watchlist.count
    }
    
    func titleFor(index: Int) -> String {
        return self.watchlist[index].symbol
    }
    
    func descriptionFor(index: Int) -> String {
        return self.watchlist[index].name
    }
    
	// MARK: - Watchlist View to Presenter Protocol

	func fetchWatchlist() {
        utilityQueue.async { [weak self] in
            self?.interactor.fetchStoredWatchlist()
        }
		
	}

	// MARK: - Watchlist Interactor to Presenter Protocol
    func didFetchWatchlist(watchlist: [StockSymbol]?, success: Bool) -> Void {
        
        mainQueue.async { [weak self] in
            
            guard let list = watchlist else {
                self?.view?.showAlert(success: false, message: "Couldn't fetch Wathlist")
                return
            }
            
            if success {
                self?.watchlist = list
                self?.view?.updateWatchList()
                self?.view?.hideActivity()
            } else {
                self?.view?.showAlert(success: false, message: "Couldn't fetch Wathlist")
            }
        }
    }
}
