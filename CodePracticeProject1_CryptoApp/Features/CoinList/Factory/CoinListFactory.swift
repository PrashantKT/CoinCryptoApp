//
//  CoinListFactory.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

final class CoinListFactory {
    
    static func viewModel() -> CoinListViewModel {
        return CoinListViewModel.init(repo: makeCoinRepo())
    }
 
    private static func makeCoinRepo() -> CoinRepositoryType {
//#if DEBUG
//        return MockCoinRepoImpl()
//#else
            
            return CoinRepositoryImpl()
//#endif
        }
}
