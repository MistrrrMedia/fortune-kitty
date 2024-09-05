//
//  ContentView.swift
//  Fortune Kitty
//
//  Created by Nicholas Nguyen on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var catViewModel = CatViewModel()
    @StateObject private var quoteViewModel = QuoteViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // cat shit
                if let errorMessage = catViewModel.errorMessage ?? quoteViewModel.errorMessage {
                    Text("Error: " + errorMessage)
                }
                
                else {
                    if let cat = catViewModel.cat {
                        if let url = URL(string: cat.url) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(20)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text("Cat ID: " + cat.id)
                                .font(.headline)
                        }
                    } else {
                        ProgressView("kitty hibernating...")
                    }
                    
                    if let quote = quoteViewModel.quote {
                        Text(quote)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        ProgressView("eeeepy...")
                    }
                    
                    Button("Fetch New Kitty") {
                        catViewModel.fetchCat()
                        quoteViewModel.fetchQuote()
                    }
                }
            }
            .padding()
            .navigationTitle("fortune kitty!")
            .onAppear {
                catViewModel.fetchCat()
                // load themes and names before fetching a quote
                DataProvider.shared.loadData()
                quoteViewModel.fetchQuote()
            }
        }
    }
}

#Preview {
    ContentView()
}
