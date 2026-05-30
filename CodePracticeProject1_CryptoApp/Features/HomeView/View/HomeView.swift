//
//  HomeView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import SwiftUI

enum HomeTab: Int, CaseIterable, Hashable {
    case coinList
    case favorite
    case settings
    case search
    var id: Self { self }
}

struct HomeView: View {
    @State private var currentTab = HomeTab.coinList
    
    var body: some View {
       
        TabView(selection: $currentTab) {
            Tab("Coin List", systemImage: "bitcoinsign.ring.dashed", value: HomeTab.coinList) {
                CoinListView()
//                Text("Coin list")
            
            }
           
            Tab("Favorite", systemImage: "heart", value: HomeTab.favorite) {
                FavoriteList()

            }
            Tab("Settings", systemImage: "gear", value: HomeTab.settings) {
                Text("Settings")
            
            }
            
            Tab(value: .search, role: .search) {
                SearchCoinView()
            }
         
        }
        
    
       
    }
}

#Preview {
    HomeView()
}
