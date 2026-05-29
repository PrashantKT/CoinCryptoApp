//
//  Untitled.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation

final class CoinRepositoryImpl: CoinRepositoryType,CoinSearchRepositoryType {
    
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
}

class MockCoinRepoImpl: CoinRepositoryType,CoinSearchRepositoryType {
    func fetchCoinList() async throws -> [Coin] {
        return .testData()
    }
    
    func fetchCoinList(searchText: String) async throws -> [Coin] {
        return .testData()
    }
}
