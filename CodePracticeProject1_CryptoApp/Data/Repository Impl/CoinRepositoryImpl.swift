//
//  Untitled.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation

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

class MockCoinRepoImpl: CoinRepositoryType,CoinSearchRepositoryType {
    func fetchCoinList() async throws -> [Coin] {
        return .testData()
    }
    
    func fetchCoinList(searchText: String) async throws -> [Coin] {
        return .testData()
    }
}
