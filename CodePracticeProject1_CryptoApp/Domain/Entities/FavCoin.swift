//
//  FavCoin.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 30/05/26.
//

import SwiftData

@Model
final class FavCoin {
    @Attribute(.unique) var id: String
    var name: String
    var symbol: String
    var image: String

    init(id: String, name: String, symbol: String, image: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
    }
}


/*
 
 List                                       fav
    
 
 --> Details                                    bit coin
       --> Fav - id
 
 */
