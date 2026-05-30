//
//  DatabaseService.swift
//  CodePracticeProject1_CryptoApp
//

import Foundation
import SwiftData

@MainActor
final class DatabaseService {
    static let shared = DatabaseService()
    
    let container: ModelContainer
    var context: ModelContext {
        container.mainContext
    }
    
    private init() {
        do {
            container = try ModelContainer(for: FavCoin.self)
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error.localizedDescription)")
        }
    }
}
