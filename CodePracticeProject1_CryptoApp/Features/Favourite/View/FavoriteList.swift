//
//  FavouriteList.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 30/05/26.
//

import SwiftUI

struct FavoriteList: View {
    
    @State var vm: FavoriteViewModel = FavoriteFactory.viewModel()
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.coins) { coin in
                    SearchRowView(coin: .init(
                        id: coin.id,
                        name: coin.name,
                        price: 0,
                        symbol: coin.symbol,
                        image: coin.image,
                        rank: 0,
                        priceChange: 0
                    ))
                    .padding(.horizontal,8)
                    .padding(.vertical,8)
                }
                .onDelete(perform: vm.delete(item:))
                .listRowInsets(EdgeInsets()) // Force true edge-to-edge spacing
                .listRowBackground(Color.clear) // Remove default row background
                .listRowSeparator(.hidden) // Hide separators between rows

            }
            .listStyle(.plain) // Style must be on the List container

            .navigationTitle("Favorite Coins")
            .overlay {
                if vm.coins.isEmpty {
                    ContentUnavailableView {
                        Label("No Favorite Coins", systemImage: "heart")
                    } description: {
                        Text("Favorite coins you add will appear here.")
                    }
                }
            }
        }
        .task {
            await vm.fetchCoins()
        }
    }
}

#Preview {
    FavoriteList()
}
