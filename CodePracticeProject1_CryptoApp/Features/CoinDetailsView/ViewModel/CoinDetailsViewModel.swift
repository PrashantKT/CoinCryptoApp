//
//  CoinDetailsViewModel.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//

import Observation

@Observable
class CoinDetailsViewModel {
    
    private let repository: CoinDetailsRepositoryType

    private(set) var state: StateMachine<CoinDetails,NetworkError> = .idle
    init(repository: CoinDetailsRepositoryType) {
        self.repository = repository
    }
    
    func fetchCoinDetails(id: String) async  {
        do {
            state = .loading
            state = .success(try await repository.fetchCoinDetails(id: id))
        } catch let error as NetworkError {
            state = .failure(error)
        } catch {
            state = .failure(.unknown)

        }
    }
    
}
