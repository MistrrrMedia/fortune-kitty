//
//  Cat_Client.swift
//  Fortune Kitty
//
//  Created by Nicholas Nguyen on 9/4/24.
//

import Foundation

class Cat_Client {
    static let shared = Cat_Client()
    
    private init() {}
    
    func fetchRandomCat(completion: @escaping (Result<Cat, Error>) -> Void ) {
        guard let apiKey = APIKeyManager.shared.getAPIKey(for: "cat_api") else {
            completion(.failure(NSError(domain: "APIKeyError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Cat API key is unavailable."])))
            return
        }
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else {
            completion(.failure(NSError(domain: "URLError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])))
            return
        }
        
        let headers = ["x-api-key": apiKey]
        
        NetworkManager.shared.performRequest(method: "GET", url: url, headers: headers) { result in
            switch result {
                case .success(let data):
                    do {
                        let cats = try JSONDecoder().decode([Cat].self, from: data)
                        if let cat = cats.first {
                            completion(.success(cat))
                        }
                        else {
                            completion(.failure(NSError(domain: "CatError", code: 3, userInfo: [NSLocalizedDescriptionKey: "No cat found in response."])))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
