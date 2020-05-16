//
//  WatchlistPresenter.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import Contracts
import Foundation

final class WatchlistPresenter {

    // MARK: - Private properties -

    private unowned let view: WatchlistViewInterface
    private let interactor: WatchlistInteractorInterface
    private let wireframe: WatchlistWireframeInterface

    private lazy var mainQueue = DispatchQueue.main
    private lazy var utilityQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: Variables
    private var watchlist: [StockSymbol] = []
    
    // MARK: - Lifecycle -

    init(view: WatchlistViewInterface, interactor: WatchlistInteractorInterface, wireframe: WatchlistWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension WatchlistPresenter: WatchlistPresenterInterface {
    
    func viewDidLoad() {
        utilityQueue.async { [weak self] in
            self?.interactor.fetchStoredWatchlist()
        }
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
    
    func didTapAddButton() {
        self.wireframe.openSearch()
    }
}

extension WatchlistPresenter: WatchlistIToPInterface {
    
    func didFetchWatchlist(watchlist: [StockSymbol]?, success: Bool) -> Void {
        
        self.mainQueue.async { [weak self] in
            guard let list = watchlist else {
                self?.view.showAlert(success: false, message: "Couldn't fetch Wathlist")
                return
            }
            if success {
                self?.watchlist = list
                self?.view.updateWatchList()
                self?.view.hideActivity()
            } else {
                self?.view.showAlert(success: false, message: "Couldn't fetch Wathlist")
            }
        }
    }
}
