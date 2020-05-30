//
//  WatchlistViewController.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import UIKit

final class WatchlistViewController: UIViewController {

    // MARK: - Private properties -
    @IBOutlet private weak var watchlist: UICollectionView!

    // MARK: - Public properties -
    var presenter: WatchlistPresenterInterface!

    // MARK: - Lifecycle -
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: Bundle.resourceBundle())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
            
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
            action: #selector(tappedAddButton)
        )
        
        self.presenter.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    @objc private func tappedAddButton() {
        self.presenter.didTapAddButton()
    }
}

// MARK: - Extensions -

extension WatchlistViewController: WatchlistViewInterface {
    
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
