//
//  WatchlistModule.swift
//  Project: MyStocks
//
//  Module: Watchlist
//
//  By Vinay Jain 26/09/19
//  Vinay Jain 2019
//

// MARK: Imports

import UIKit

// MARK: -

/// Used to initialize the Watchlist VIPER module
final class WatchlistModule {

	// MARK: - Variables

	private(set) lazy var interactor: WatchlistInteractor = {
		WatchlistInteractor()
	}()

	private(set) lazy var router: WatchlistRouter = {
		WatchlistRouter()
	}()

	private(set) lazy var presenter: WatchlistPresenter = {
		WatchlistPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: WatchlistViewController = {
		WatchlistViewController(presenter: self.presenter)
	}()

	// MARK: - Module Protocol Variables

	var viewController: UIViewController {
		return view
	}

	// MARK: Inits

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}
