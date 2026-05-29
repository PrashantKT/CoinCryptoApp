//
//  NetworkError.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation

enum NetworkError: MessageError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(underlaying: Error)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .decodingError(underlaying: let error):
            return "Decoding error: \(error.localizedDescription)"
        case .unknown:
            return "Something went wrong !!"

        }
    }
    
    var userFriendlyMessage: String {
        return localizedDescription
    }

}
