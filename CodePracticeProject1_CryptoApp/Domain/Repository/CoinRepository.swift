//
//  CoinRepository.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

protocol CoinRepositoryType {
    func fetchCoinList() async throws -> [Coin]
}

protocol CoinSearchRepositoryType {
    func fetchCoinList(searchText: String) async throws -> [Coin]
}
