//
//  DataProvider.swift
//  Fortune Kitty
//
//  Created by Nicholas Nguyen on 9/4/24.
//

import Foundation

struct QuoteData: Codable {
    let themes: [String]
}

class DataProvider {
    static let shared = DataProvider()
    
    private init() {}
    
    var quoteData: QuoteData?
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Failed to locate data.json.")
            return
        }
        
        do {
            // load json contents
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            quoteData = try decoder.decode(QuoteData.self, from: data)
        } catch {
            print("Failed to load or parse data.json")
        }
    }
    
    func getRandomTheme() -> String {
        return quoteData?.themes.randomElement() ?? "random theme"
    }
}
