//
//  EndPoint.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation

enum HttpMethod: String {
    case GET, POST
}

protocol EndPointType {
    var path: String {get}
    var httpMethod: HttpMethod {get}
    var queryParams: [URLQueryItem] {get}
    var httpBody: Data? {get}
    var httpHeader: [String: String] {get}
}

extension EndPointType {
    var queryParams: [URLQueryItem] {[]}
    var httpBody: Data? {nil}
    var httpHeader: [String: String] { ["Content-Type": "application/json"]}
}

enum EndPoint: EndPointType {
    case coinList
    case searchCoin(String)
    case coinDetails(String)
    
    var path: String {
        switch self {
        case .coinList:
            return "/coins/markets"             //https://api.coingecko.com/api/v3/coins/markets?ids=bnb,bitcoin&vs_currency=usd

        case .searchCoin:
            return "/search"
        case .coinDetails(let id):
            return "/coins/\(id)"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .coinList,.searchCoin,.coinDetails:
            return .GET
        }
    }
    
    var queryParams: [URLQueryItem] {
        switch self {
        case .coinList:
            return [.init(name: "vs_currency", value: "USD")]
        case .searchCoin(let search):
            return [.init(name: "query", value: search)]
        case .coinDetails:
            return [.init(name: "localization", value: "false")]
        }
    }
}
