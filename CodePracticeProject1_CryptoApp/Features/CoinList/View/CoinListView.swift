//
//  CoinListView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import SwiftUI

struct CoinListView: View {
    
    @State private var vm: CoinListViewModel = CoinListFactory.viewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch vm.state {
                case .loading, .idle:
                    ProgressView("Loading ...")
                case .failure(let error):
                    failureView(error: error)
                case .success( let coins ):
                    ScrollView {
                        LazyVStack {
                            ForEach(coins) { coin in
                                CoinRawView(coin: coin)
                                    .padding(.horizontal)
                                    .padding(.vertical,6)
                            }
                        }
                    }
                  
                }
            }
            .navigationTitle("Coins")
            .task {
                await vm.fetchCoins()
            }
            .refreshable {
                await vm.fetchCoins(force: true)
            }
        }
       
    }
    
    func failureView(error: NetworkError) -> some View {
        ErrorViewAction(title: error.userFriendlyMessage, message: "Something went wrong, Please wait and try again", systemImage: "wifi.exclamationmark") {
            await vm.fetchCoins()
        }
       
    }
}



#Preview {
    CoinListView()
}
