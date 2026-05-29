//
//  CoinMapper.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

extension CointDTO {
    func toCoin() -> Coin? {
        return .init(name: name, price: current_price, symbol: symbol, image: image,rank: market_cap_rank, priceChange: price_change_percentage_24h)
    }
}

extension CoinSearchDTO {
    func toCoin() -> Coin? {
        return .init(name: name, price: 0, symbol: symbol, image: thumb,rank: market_cap_rank, priceChange: 0)
    }
}
