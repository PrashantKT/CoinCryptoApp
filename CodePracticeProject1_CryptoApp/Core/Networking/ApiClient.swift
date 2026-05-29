//
//  ApiClient.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation

final class ApiClient: NSObject {
    
    var reqBuilder: RequestBuilderProtocol
    var urlSession: URLSession
    
    
    init(reqBuilder: RequestBuilderProtocol = RequestBuilder(),urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        self.reqBuilder = reqBuilder
        super.init()
    }
    
    func sendRequest<T: Decodable>(endPoint: EndPointType) async throws -> T {
        let req = try reqBuilder.buildRequest(for: endPoint)
        let (data,res) = try await urlSession.data(for: req)
        
        guard let res = res as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(res.statusCode) else {
            throw NetworkError.httpError(res.statusCode)
        }
        
        do {
            
            let jsonDecoder = JSONDecoder()
            let parsing = try jsonDecoder.decode(T.self, from: data)
            return parsing

        } catch {
            throw NetworkError.decodingError(underlaying: error)
        }
        
    }
}
