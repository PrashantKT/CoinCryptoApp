//
//  CoinMapper.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

extension CointDTO {
    func toCoin() -> Coin? {
        return .init(id: id,name: name, price: current_price, symbol: symbol, image: image,rank: market_cap_rank, priceChange: price_change_percentage_24h)
    }
}

extension CoinSearchDTO {
    func toCoin() -> Coin? {
        return .init(id: id,name: name, price: 0, symbol: symbol, image: thumb,rank: market_cap_rank, priceChange: 0)
    }
}

extension CoinDetailsDTO {
    func toCoin() -> CoinDetails {
        let md = self.market_data
        return .init(
            id: self.id,
            symbol: self.symbol,
            name: self.name,
            rank: self.rank,
            image: self.image,
            description: self.description,
            current_price: md.current_price,
            market_cap: md.market_cap,
            price_change_24h: md.price_change_24h,
            total_volume: md.total_volume,
            allTimeHigh: md.allTimeHigh,
            allTimeLow: md.allTimeLow,
            price_change_percentage_24h: md.price_change_percentage_24h,
            price_change_percentage_7d: md.price_change_percentage_7d,
            price_change_percentage_14d: md.price_change_percentage_14d,
            price_change_percentage_30d: md.price_change_percentage_30d,
            price_change_percentage_60d: md.price_change_percentage_60d,
            price_change_percentage_200d: md.price_change_percentage_200d,
            price_change_percentage_1y: md.price_change_percentage_1y
        )
    }
}

extension Coin {
    func toFavCoin() -> FavCoin {
        return .init(id: id, name: name, symbol: symbol, image: image)
    }
}
