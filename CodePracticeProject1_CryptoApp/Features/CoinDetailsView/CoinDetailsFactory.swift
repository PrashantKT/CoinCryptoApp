//
//  CoinDetailsFactory.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//

final class CoinDetailsFactory {
    static func makeViewModel() -> CoinDetailsViewModel {
        CoinDetailsViewModel(repository:coinDetailsRepo())
    }
    
    private static func coinDetailsRepo() -> CoinDetailsRepositoryType {
        return CoinRepositoryImpl()
    }
    
}
