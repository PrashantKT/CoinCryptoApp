//
//  CoinSearchDTO.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//


struct SearchResult: Decodable {
    var coins: [CoinSearchDTO]
}

struct CoinSearchDTO: Decodable {
    
    var id: String
    var name: String
    var api_symbol: String
    var symbol: String
    var market_cap_rank: Int
    var thumb: String
    
}
