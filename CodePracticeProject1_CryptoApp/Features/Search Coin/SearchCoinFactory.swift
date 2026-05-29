//
//  SearchCoinFactory.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//
import Foundation

final class SearchCoinFactory {
    
    static func makeVM() -> SearchCoinViewModel {
        SearchCoinViewModel(searchRepo: makeRepo())
    }
    
    private static func makeRepo() -> CoinSearchRepositoryType {
//#if DEBUG
//        return MockCoinRepoImpl()
//#else
        
        return CoinRepositoryImpl()
//#endif
    }
}
