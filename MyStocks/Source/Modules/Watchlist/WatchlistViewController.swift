//
//  WatchlistViewController.swift
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

/// Should be conformed to by the `WatchlistViewController` and referenced by `WatchlistPresenter`
protocol WatchlistPresenterViewProtocol: ActivityViewProtocol {
	func updateWatchList()
}

// MARK: -

/// The View Controller for the Watchlist module
class WatchlistViewController: UIViewController, WatchlistPresenterViewProtocol {

	// MARK: - Constants

	let presenter: WatchlistViewPresenterProtocol

	// MARK: Variables

    @IBOutlet weak var watchlist: UICollectionView!
    // MARK: Inits

	init(presenter: WatchlistViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
        self.title = "Watchlist"
		view.backgroundColor = .white
        if let layout = watchlist.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 80)
        }
        
        watchlist.register(UINib(nibName: StockCell.reuseId, bundle: nil), forCellWithReuseIdentifier: StockCell.reuseId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(openSearchVC)
        )
        
        presenter.fetchWatchlist()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    
    @objc func openSearchVC() {
        
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
	// MARK: - Watchlist Presenter to View Protocol
    func updateWatchList() {
        self.watchlist.reloadData()
    }
    
}

extension WatchlistViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StockCell.reuseId,
            for: indexPath
            ) as? StockCell else { return UICollectionViewCell() }
                
        cell.stockNameLbl.text = presenter.titleFor(index: indexPath.item)                
        return cell
    }
    
}
