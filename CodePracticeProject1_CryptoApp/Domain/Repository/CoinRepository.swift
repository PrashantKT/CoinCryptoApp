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

protocol CoinDetailsRepositoryType {
    func fetchCoinDetails(id: String) async throws -> CoinDetails
}

@MainActor
protocol FavCoinRepositoryType {
    func addCoinToFav(coin: FavCoin) async throws
    func removeCoinFromFav(id: String) async throws
    func fetchFavCoinList() async throws -> [FavCoin]
    func isFavorite(id: String) throws -> Bool
}
