//
//  call demo.swift
//  Fortune Kitty
//
//  Created by Nicholas Nguyen on 9/3/24.
//

import Foundation
import Combine

class CatViewModel: ObservableObject {
    @Published var cat: Cat?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCat() {
        Cat_Client.shared.fetchRandomCat() { [weak self] result in
            DispatchQueue.main.sync {
                switch result {
                    case .success(let cat):
                        self?.cat = cat
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
