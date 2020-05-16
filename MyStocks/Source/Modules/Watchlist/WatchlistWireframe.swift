//
//  WatchlistWireframe.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import UIKit

final class WatchlistWireframe: BaseWireframe {

    // MARK: - Module setup -

    init() {
        let moduleViewController = WatchlistViewController()
        super.init(viewController: moduleViewController)

        let interactor = WatchlistInteractor()
        let presenter = WatchlistPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
        interactor.presenter = presenter
    }

}

// MARK: - Extensions -

extension WatchlistWireframe: WatchlistWireframeInterface {
    func openSearch() {
        let searchWireframe = SearchWireframe()
        self.navigationController?.pushWireframe(searchWireframe)
    }
    
}
