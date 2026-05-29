//
//  CointDTO.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

struct CointDTO: Codable,Identifiable {
    var id:String
    var symbol: String
    var name: String
    var image:String
    var current_price: Double
    var market_cap: Double
    var price_change_percentage_24h: Double
    var market_cap_rank: Int
    
}
