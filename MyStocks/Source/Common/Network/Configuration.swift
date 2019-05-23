//
//  Configuration.swift
//  MyStocks
//
//  Created by Vinay Jain on 22/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    public init?(contentsOfFile path: String) {
        let url = URL(fileURLWithPath: path)
        
        self.init(contentsOfURL: url)
    }
    
    public init?(contentsOfURL url: URL) {
        guard let data = try? Data(contentsOf: url),
            let dictionary = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]) ?? nil
            else { return nil }
        
        self = dictionary
    }
}

public struct Configuration {
    
    static let shared = Configuration(configFileUrl: Bundle.main.url(forResource: "config", withExtension: "plist")!)
    
    public let baseUrl: String
    public let apiKey: String
    
    private init?(configFileUrl: URL) {
        guard let dict = Dictionary(contentsOfURL: configFileUrl),
            let serverUrl = dict["STOCKS_API_BASE_URL"] as? String,
            let apiKey = dict["STOCKS_API_KEY"] as? String else { return nil }
        self.baseUrl = serverUrl
        self.apiKey = apiKey
    }
    
}
