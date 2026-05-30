//
//  Untitled.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation
import SwiftData

final class CoinRepositoryImpl: CoinRepositoryType,CoinSearchRepositoryType, CoinDetailsRepositoryType {
    
    func fetchCoinList() async throws -> [Coin] {
        let apiClient = ApiClient()
        let coins:[CointDTO] = try await apiClient.sendRequest(endPoint: EndPoint.coinList)
        return coins.compactMap{$0.toCoin()}
    }
    
    func fetchCoinList(searchText: String) async throws -> [Coin] {
        let apiClient = ApiClient()
        let coin:SearchResult = try await apiClient.sendRequest(endPoint: EndPoint.searchCoin(searchText))
        return coin.coins.compactMap{$0.toCoin()}
    }
    
    func fetchCoinDetails(id: String) async throws -> CoinDetails {
        let apiClient = ApiClient()
        let coin:CoinDetailsDTO = try await apiClient.sendRequest(endPoint: EndPoint.coinDetails(id))
        return coin.toCoin()
    }
}

final class FavRepoImpl: FavCoinRepositoryType {
    
    @MainActor
    private var context: ModelContext {
        DatabaseService.shared.context
    }
    
    init() {}
    
    func addCoinToFav(coin: FavCoin) async throws {
        
        context.insert(coin)
        try context.save()
    }
    
    func removeCoinFromFav(id: String) async throws {
        let fetchDesc = FetchDescriptor<FavCoin>(predicate: #Predicate { model in
            model.id == id
        })
        if let fetch = try context.fetch(fetchDesc).first {
            context.delete(fetch)
            try context.save()
        }
    }
    
    func fetchFavCoinList() async throws -> [FavCoin] {
        let fetch =  FetchDescriptor<FavCoin>()
        let coins =  try context.fetch(fetch)
        return coins
    }
    
    
    func isFavorite(id: String)  throws -> Bool {
        let predicate = #Predicate<FavCoin> { coin in
            coin.id == id
        }
        let fetchReque = FetchDescriptor(predicate: predicate)
        return try  context.fetch(fetchReque).isEmpty == false
    }
    
}

class MockCoinRepoImpl: CoinRepositoryType,CoinSearchRepositoryType {
    func fetchCoinList() async throws -> [Coin] {
        return .testData()
    }
    
    func fetchCoinList(searchText: String) async throws -> [Coin] {
        return .testData()
    }
}
