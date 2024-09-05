//
//  NetworkManager.swift
//  Fortune Kitty
//
//  connects to endpoint, performs API requests
//
//  Created by Nicholas Nguyen on 9/2/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func performRequest(method: String = "GET", url: URL, headers: [String: String]? = nil, body: Data? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data returned from server."])))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
