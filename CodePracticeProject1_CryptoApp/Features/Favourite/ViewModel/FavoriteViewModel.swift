//
//  FavoriteViewModel.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 30/05/26.
//

import Observation
import Foundation

@Observable
class FavoriteViewModel {
    var coins = [FavCoin]()
    var error: String?
    
    private let service: FavCoinRepositoryType
    
    init(coins: [FavCoin] = [FavCoin](), service: FavCoinRepositoryType) {
        self.coins = coins
        self.service = service
    }
    
    func fetchCoins() async {
        do {
            coins = try await service.fetchFavCoinList()
        } catch {
            self.error = "Something went wrong "
        }
    }
    
    func delete(item: IndexSet) {
        Task {
            await  withTaskGroup(of: String.self) {[coins] group in
                for id in item {
                    group.addTask {
                        await  self.removeCoin(id: coins[id].id)
                        return coins[id].id
                    }
                }
               
               for await result in group {
                   print("Deleted \(result)")
                   
               }
            }
            await fetchCoins()
        }
      
    }
    
    private func removeCoin(id: String) async {
        do {
            try await service.removeCoinFromFav(id: id)
            coins.removeAll(where: {$0.id == id})
            
        } catch {
            
        }
    }
    
}
