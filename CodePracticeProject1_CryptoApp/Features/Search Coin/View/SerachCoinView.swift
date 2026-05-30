//
//  SerachCoinView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//


import SwiftUI

struct SearchCoinView: View {
    
    @State private var vm: SearchCoinViewModel  = SearchCoinFactory.makeVM()
    var body: some View {
        NavigationStack {
            Group {
                switch vm.state {
                case .idle:
                    ContentUnavailableView("Search Crypto", systemImage: "bitcoinsign.circle", description: Text("Type a coin name or ticker to get started."))

                case .loading:
                    ProgressView("Please wait")
                case .failure(let error):
                    ErrorViewAction(title: error.userFriendlyMessage, message: "Something went wrong", systemImage: "wifi.exclamationmark") {
                        
                    }
                case .success(let coins):
                    if coins.isEmpty {
                        ContentUnavailableView.search(text: vm.searchText)

                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(coins){ coin in
                                    NavigationLink(destination: CoinDetailsView(id: coin.id)) {
                                        
                                        SearchRowView(coin: coin)
                                            .padding(.horizontal)
                                            .padding(.vertical, 4)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Coins")
            .searchable(text: $vm.searchText, prompt: "Search coins")
            
            .task(id:vm.searchText) {
                await vm.searchDebounce()
            }
        }
    }
}

#Preview {
    SearchCoinView()
}
