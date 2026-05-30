//
//  FavoriteFactory.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 30/05/26.
//

import SwiftData

final class FavoriteFactory {
    
    static func viewModel() -> FavoriteViewModel {
        return FavoriteViewModel(service: repository())
    }
    
    static func repository() -> FavCoinRepositoryType {
        return FavRepoImpl()
    }
}
