//
//  Data+Addons.swift
//  MyStocksTests
//
//  Created by Vinay Jain on 16/05/20.
//  Copyright (c) 2020 Vinay Jain. All rights reserved.
//

import Foundation

class Helper {

	static func dataFromFile(name: String, type: String = "json") -> Data? {
		guard let url = Bundle(for: self).url(forResource: name, withExtension: type),
			let data = try? Data(contentsOf: url)
			else {
				return nil
		}
		return data
	}
}
