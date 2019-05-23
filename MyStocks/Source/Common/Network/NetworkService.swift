//
//  NetworkService.swift
//  MyStocks
//
//  Created by Vinay Jain on 16/05/19.
//  Copyright © 2019 Vinay Jain. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum Function: String {
    case symbolSearch = "SYMBOL_SEARCH"
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        
        switch method {
        case .get, .delete:
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }
        
        self = components.url!
    }
}

extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        switch method {
        case .post, .put:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
}

final class WebClient {
    
    func load(path: String = "", method: RequestMethod, params: JSON, completion: @escaping (Data?, ServiceError?) -> ()) -> URLSessionDataTask? {
        // Checking internet connection availability
        if !Reachability.isConnectedToNetwork() {
            completion(nil, ServiceError.noInternetConnection)
            return nil
        }
        
        
        guard let config = Configuration.shared else {
            completion(nil, ServiceError.other)
            return nil
        }
        var params = params
        params["apikey"] = config.apiKey
        
        // Creating the URLRequest object
        let request = URLRequest(baseUrl: config.baseUrl, path: path, method: method, params: params)
        
        // Sending request to the server.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                completion(data, nil)
            } else {
                completion(nil, ServiceError.other)
            }
        }
        task.resume()
        return task
    }
}
