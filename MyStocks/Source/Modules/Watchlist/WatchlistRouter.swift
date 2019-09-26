//
//  WatchlistRouter.swift
//  Project: MyStocks
//
//  Module: Watchlist
//
//  By Vinay Jain 26/09/19
//  Vinay Jain 2019
//

// MARK: Imports

import UIKit


// MARK: Protocols

/// Should be conformed to by the `WatchlistRouter` and referenced by `WatchlistPresenter`
protocol WatchlistPresenterRouterProtocol {

}

// MARK: -

/// The Router for the Watchlist module
final class WatchlistRouter: WatchlistPresenterRouterProtocol {

	// MARK: - Variables

	weak var viewController: UIViewController?
}
