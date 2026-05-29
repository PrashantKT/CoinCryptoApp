//
//  NetworkFailureLogging.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import Foundation
import OSLog

final class NetworkLogger: CommonLogger {
    let l = Logger.init(subsystem: "com.prashant.network", category: "Network")

    func log(msg message: String) {
        l.debug("\(message)")
    }
    
    
}
