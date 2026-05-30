//
//  CoinListViewModel.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Observation
import Foundation

@Observable
final class CoinListViewModel {
        
    var repo: CoinRepositoryType
    var state:StateMachine<[Coin],NetworkError> = .idle
    var searchText = ""
    private var coins: [Coin] =  []
    init(repo: CoinRepositoryType) {
        self.repo = repo
    }
    
    func fetchCoins(force: Bool = false ) async {
        // Early exits no reload again
        if case .success = state , !force {
            return
        }
        self.searchText = ""
        state = .loading
        do {
            let coins = try await repo.fetchCoinList()
            self.coins = coins
            
            state = .success(self.coins)
        } catch let error as NetworkError {
            print(error)
            state = .failure(error)
        } catch {
            print(error)
            state = .failure(.unknown)
        }
    }
    
    func searchCoinLocally() {
        guard searchText.isEmpty == false else {
            if case .success = state {
                state = .success(self.coins)
            }
            return
        }
        state = .success(self.coins.filter{$0.name.localizedStandardContains(searchText)})
    }
}

extension Array where Element == Coin {
    static func testData() -> [Coin] {
        return [
            .init(id: "bitcoin", name: "BTC", price: 152, symbol: "btc", image: "tset",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(id: "ethereum", name: "Dfef", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(id: "bitcoin", name: "Dfgdf", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(id: "bitcoin", name: "D", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(id: "bitcoin", name: "effD", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
        ]
    }
}
