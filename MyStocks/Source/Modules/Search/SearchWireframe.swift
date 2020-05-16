//
//  SearchWireframe.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import UIKit

final class SearchWireframe: BaseWireframe {

    // MARK: - Module setup -

    init() {
        let moduleViewController = SearchViewController()
        super.init(viewController: moduleViewController)

        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
        interactor.presenter = presenter
    }

}

// MARK: - Extensions -

extension SearchWireframe: SearchWireframeInterface {
}
