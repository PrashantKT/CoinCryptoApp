//
//  SearchCoinViewModel.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//

import SwiftUI
import Observation

@Observable
class SearchCoinViewModel {
    private let searchRepo: CoinSearchRepositoryType
    var state = StateMachine<[Coin],NetworkError>.idle
    var searchText = ""
    init(searchRepo: CoinSearchRepositoryType) {
        self.searchRepo = searchRepo
    }
    
    func searchCoin(query: String) async {
        state = .loading
        do {
            state = .success(try await searchRepo.fetchCoinList(searchText: query))
        } catch let error as NetworkError {
            state = .failure(error)
        } catch {
            state = .failure(.unknown)

        }
    }
    
    func searchDebounce() async {
        let cleanQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard cleanQuery.isEmpty == false else {
            state = .idle
            return
        }
        do {
            try await Task.sleep(for: .milliseconds(300))
            try Task.checkCancellation()
            await searchCoin(query: searchText)

        } catch {
            if error is CancellationError {
                print("User is still typing... cancelled search for: \(cleanQuery)")
            } else {
                print("Actual network/processing error occurred: \(error)")
            }
        }
    }
}
