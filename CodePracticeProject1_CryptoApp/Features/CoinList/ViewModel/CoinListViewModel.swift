//
//  CoinListViewModel.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Observation

@Observable
final class CoinListViewModel {
        
    var repo: CoinRepositoryType
    var state:StateMachine<[Coin],NetworkError> = .idle
    init(repo: CoinRepositoryType) {
        self.repo = repo
    }
    
    func fetchCoins(force: Bool = false ) async {
        // Early exits no reload again
        if case .success = state , !force {
            return
        }
        
        state = .loading
        do {
            let coins = try await repo.fetchCoinList()
            state = .success(coins)
        } catch let error as NetworkError {
            print(error)
            state = .failure(error)
        } catch {
            print(error)
            state = .failure(.unknown)
        }
    }
}

extension Array where Element == Coin {
    static func testData() -> [Coin] {
        return [
            .init(name: "BTC", price: 152, symbol: "btc", image: "tset",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(name: "Dfef", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(name: "Dfgdf", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
                .init(name: "D", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
            .init(name: "effD", price: 152, symbol: "btc", image: "test",rank: 1,priceChange: Double.random(in: 12...51)),
        ]
    }
}
