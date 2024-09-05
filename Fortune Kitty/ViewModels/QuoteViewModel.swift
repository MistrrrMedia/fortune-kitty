//
//  QuoteViewModel.swift
//  Fortune Kitty
//
//  Created by Nicholas Nguyen on 9/4/24.
//

import Foundation
import Combine

class QuoteViewModel: ObservableObject {
    @Published var quote: String? = "eeeeeepy"
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchQuote() {
        OpenAI_Client.shared.generateQuote() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let generatedQuote):
                        self?.quote = generatedQuote
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
