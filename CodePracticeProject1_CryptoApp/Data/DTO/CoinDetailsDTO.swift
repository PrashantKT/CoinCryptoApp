//
//  CoinDetailsDTO.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//


struct MarketDataDTO : Decodable {
    var current_price: Double // done
    var market_cap: Double // done
    var price_change_24h: Double
    var total_volume: Double
    var allTimeHigh: Double
    var allTimeLow: Double
    var price_change_percentage_24h: Double
    var price_change_percentage_7d: Double
    var price_change_percentage_14d: Double
    var price_change_percentage_30d: Double
    var price_change_percentage_60d: Double
    var price_change_percentage_200d: Double
    var price_change_percentage_1y: Double
    
    enum CodingKeys: String, CodingKey {
        case current_price = "current_price"
        case market_cap = "market_cap"
        case price_change_24h = "price_change_24h"
        case total_volume = "total_volume"
        case allTimeHigh = "ath"
        case allTimeLow = "atl"
        case price_change_percentage_24h,price_change_percentage_7d,price_change_percentage_14d,price_change_percentage_30d,price_change_percentage_60d,price_change_percentage_200d,price_change_percentage_1y
    }
    
    enum ChildUSDContainer: CodingKey {
        case usd
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let childUSDContainer =  try container.nestedContainer(keyedBy: ChildUSDContainer.self, forKey: .current_price)
        self.current_price = try childUSDContainer.decode(Double.self, forKey: .usd)
        
        let market_cap_Container =  try container.nestedContainer(keyedBy: ChildUSDContainer.self, forKey: .market_cap)
        self.market_cap = try market_cap_Container.decode(Double.self, forKey: .usd)

        let ath_container =  try container.nestedContainer(keyedBy: ChildUSDContainer.self, forKey: .allTimeHigh)
        self.allTimeHigh = try ath_container.decode(Double.self, forKey: .usd)
        
        let atl_container_low =  try container.nestedContainer(keyedBy: ChildUSDContainer.self, forKey: .allTimeLow)
        self.allTimeLow = try atl_container_low.decode(Double.self, forKey: .usd)

        let toalVolume_container =  try container.nestedContainer(keyedBy: ChildUSDContainer.self, forKey: .total_volume)

        self.total_volume = try toalVolume_container.decode(Double.self, forKey: .usd)

        self.price_change_24h = try container.decode(Double.self, forKey: .price_change_24h)
        
        
        self.price_change_percentage_24h = try container.decode(Double.self, forKey: .price_change_percentage_24h)
        self.price_change_percentage_7d = try container.decode(Double.self, forKey: .price_change_percentage_7d)
        self.price_change_percentage_14d = try container.decode(Double.self, forKey: .price_change_percentage_14d)
        self.price_change_percentage_30d = try container.decode(Double.self, forKey: .price_change_percentage_30d)
        self.price_change_percentage_60d = try container.decode(Double.self, forKey: .price_change_percentage_60d)
        self.price_change_percentage_200d = try container.decode(Double.self, forKey: .price_change_percentage_200d)
        self.price_change_percentage_1y = try container.decode(Double.self, forKey: .price_change_percentage_1y)
    }
    
  
}

struct CoinDetailsDTO: Decodable {
    
    let id,symbol, name: String
    let rank: Int
    let image:String
    var description:String
    var market_data: MarketDataDTO
    enum CodingKeys:String, CodingKey {
        case id
        case symbol
        case name
        case rank = "market_cap_rank"
        case image
        case description
        case market_data
    }
    
    enum DescriptionKeys: CodingKey {
        case en
    }
    
    enum CoinDetailsImageKeys: CodingKey {
        case thumb,small,large
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.rank = try container.decode(Int.self, forKey: .rank)
        self.market_data = try container.decode(MarketDataDTO.self, forKey: .market_data)

        let container_image = try container.nestedContainer(keyedBy: CoinDetailsImageKeys.self, forKey: .image)
        self.image = try container_image.decode(String.self, forKey: .large)
        
        let container_description = try container.nestedContainer(keyedBy: DescriptionKeys.self, forKey: .description)
        self.description = try container_description.decode(String.self, forKey: .en)
        
    }
}

