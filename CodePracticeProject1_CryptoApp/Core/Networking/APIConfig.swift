//
//  ApiConstants.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//
import Foundation

enum APIConfig {
    static let baseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            // Log to your analytics platform or use a safe fallback instead of crashing
            assertionFailure("BaseURL missing from Info.plist")
            return "https://coingecko.com"
        }
        return url
    }()
}
