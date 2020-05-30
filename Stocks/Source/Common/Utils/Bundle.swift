//
//  Bundle.swift
//  MyStocks
//
//  Created by Vinay Jain on 29/01/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import Foundation


extension Bundle {
    class func resourceBundle() -> Bundle {
        let resourceBundlePath = Bundle.main.path(forResource: "../StockResources", ofType: "bundle")!
        let bundle = Bundle(path: resourceBundlePath)!
        bundle.load()
        return bundle
    }
}
