//
//  APIKeyManager.swift
//  Fortune Kitty
//
//  retrieve API key(s) from config.json file
//
//  in format
//    {
//        "services" : {
//            "serviceName": {
//                "api_key": "value",
//                ...
//            },
//            ...
//        }
//    }
//
//  Created by Nicholas Nguyen on 9/2/24.
//

import Foundation

class APIKeyManager {
    static let shared = APIKeyManager()
    private var apiKeys: [String: String] = [:]
    
    private init() {
        loadAPIKey()
    }
    
    private func loadAPIKey() {
        guard let url = Bundle.main.url(forResource: "config", withExtension: "json") else {
            print("Failued to locate config.json.")
            return
        }
        
        do {
            // load json contents
            let data = try Data(contentsOf: url)
            
            // json to dictionary
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let services = json["services"] as? [String: Any] {

                // iterate over each service
                for (serviceName, serviceDetails) in services {
                    if let serviceDict = serviceDetails as? [String: String],
                    let apiKey = serviceDict["api_key"] {
                        apiKeys[serviceName] = apiKey
                    }
                }
            }
        } catch {
            print("Couldn't retrieve API key from JSON file: " + error.localizedDescription + ".")
        }
    }
    
    func getAPIKey(for service: String) -> String? {
        return apiKeys[service]
    }
}
