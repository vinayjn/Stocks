//
//  StockCell.swift
//  MyStocks
//
//  Created by Vinay Jain on 26/09/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import UIKit

class StockCell: UICollectionViewCell {

    @IBOutlet weak var stockNameLbl: UILabel!
    
    static let reuseId = "StockCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let radius: CGFloat = 8
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = radius
        // Always mask the inside view
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.15
        
        // Never mask the shadow as it falls outside the view
        self.layer.masksToBounds = false
        
        // Matching the contentView radius here will keep the shadow
        // in sync with the contentView's rounded shape
        self.layer.cornerRadius = radius
        
    }

}
