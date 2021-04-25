//
//  SearchPresenterTests.swift
//  MyStocksTests
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import StockContracts
@testable import MyStocks
import XCTest

final class SearchViewMock: SearchViewInterface {
    
    private(set) var didUpdateList: Bool = false
    private(set) var didSaveSuccessfuly: Bool = false
    private(set) var didShowActivity: Bool = false
    private(set) var didHideActivity: Bool = false
    
    var saveExpectation: XCTestExpectation?
    var searchExpectation: XCTestExpectation?
    
    func showAlert(success: Bool, message: String) {
        self.didSaveSuccessfuly = success
        self.saveExpectation?.fulfill()
    }
    
    func showActivity() {
        self.didShowActivity = true
    }
    
    func hideActivity() {
        self.didHideActivity = true
    }
    
    func updateList() {
        self.didUpdateList = true
        self.searchExpectation?.fulfill()
    }
}

final class SearchWireframeMock: SearchWireframeInterface {}

private enum InteractorRequest {
    case search
    case save
}

final class SearchInteractorMock: SearchInteractorInterface {
    
    fileprivate var requestFailures: [InteractorRequest] = []
    
    var presenter: SearchIToPInterface?
    
    private func loadJSON<T: Decodable>(name: String) -> T? {
        guard let data = Helper.dataFromFile(name: name), let response = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return response
    }
    
    func searchStocks(forQuery query: String) {
        self.presenter?.findingSymbols(for: query)
        if self.requestFailures.contains(.search) {
            self.presenter?.didFind(symbols: [])
        } else {
            guard let data = Helper.dataFromFile(name: "search"), let response = try? SymbolSearchResponse(jsonUTF8Data: data) else {
                self.presenter?.didFind(symbols: [])
                return
            }
            self.presenter?.didFind(symbols: response.symbols)
        }
    }
    
    func saveSymbolToWatchlist(symbol: StockSymbol) {
        if self.requestFailures.contains(.save) {
            self.presenter?.didSave(symbol: symbol, success: false)
        } else {
            self.presenter?.didSave(symbol: symbol, success: true)
        }
    }
}


class SearchPresenterTests: XCTestCase {
    
    private var wireframe: SearchWireframeMock!
    private var view: SearchViewMock!
    private var interactor: SearchInteractorMock!
    private var presenter: SearchPresenterInterface!
    
    override func setUp() {
        self.wireframe = SearchWireframeMock()
        self.view = SearchViewMock()
        self.interactor = SearchInteractorMock()
        let presenter = SearchPresenter(view: self.view, interactor: self.interactor, wireframe: self.wireframe)
        self.interactor.presenter = presenter
        self.presenter = presenter
    }
    
    func testSearchSuccess() {
        self.presenter.searchSymbols(for: "BDRBF")
        let expectation = XCTestExpectation()
        self.view.searchExpectation = expectation
        wait(for: [expectation], timeout: 0.3)
        
        XCTAssert(self.view.didShowActivity)
        XCTAssert(self.view.didHideActivity)
        XCTAssert(self.view.didUpdateList)
        
        XCTAssert(self.presenter.numberOfRows == 2)
        XCTAssert(self.presenter.titleFor(index: 0) == "BDRBF")
        XCTAssert(self.presenter.descriptionFor(index: 0) == "Bombardier")
    }
    
    func testSearchFailure() {
        self.interactor.requestFailures.append(.search)
        self.presenter.searchSymbols(for: "BDRBF")
        let expectation = XCTestExpectation()
        self.view.searchExpectation = expectation
        wait(for: [expectation], timeout: 0.3)
        
        XCTAssert(self.view.didShowActivity)
        XCTAssert(self.view.didHideActivity)
        XCTAssert(self.view.didUpdateList)
        XCTAssert(self.presenter.numberOfRows == 0)
    }
    
    func testSaveSuccess() {
        self.presenter.searchSymbols(for: "BDRBF")
        let searchExpectation = self.expectation(description: "Search Expectation")
        self.view.searchExpectation = searchExpectation
        
        
        waitForExpectations(timeout: 0.3) { (_) in
            self.presenter.selectedSymbolAt(index: 0)
            let saveExpectation = self.expectation(description: "Save Expectation")
            self.view.saveExpectation = saveExpectation
            self.waitForExpectations(timeout: 0.3) { (_) in
                XCTAssert(self.view.didSaveSuccessfuly)
            }
        }
    }
    
    func testSaveFailure() {
        self.presenter.searchSymbols(for: "BDRBF")
        let searchExpectation = self.expectation(description: "Search Expectation")
        self.view.searchExpectation = searchExpectation
        self.interactor.requestFailures.append(.save)
        waitForExpectations(timeout: 0.3) { (_) in
            self.presenter.selectedSymbolAt(index: 0)
            let saveExpectation = self.expectation(description: "Save Expectation")
            self.view.saveExpectation = saveExpectation
            self.waitForExpectations(timeout: 0.3) { (_) in
                XCTAssertFalse(self.view.didSaveSuccessfuly)
            }
        }
    }
}
