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
    private let favoritesRepository: FavCoinRepositoryType

    private(set) var state: StateMachine<CoinDetails,NetworkError> = .idle
    init(repository: CoinDetailsRepositoryType, favoritesRepository: FavCoinRepositoryType) {
        self.repository = repository
        self.favoritesRepository = favoritesRepository
    }
    
    var isFav: Bool = false
    
    func fetchCoinDetails(id: String) async  {
        do {
            state = .loading
            state = .success(try await repository.fetchCoinDetails(id: id))
           
            isFav = (try? favoritesRepository.isFavorite(id: id)) ?? false
             
           
        } catch let error as NetworkError {
            state = .failure(error)
        } catch {
            state = .failure(.unknown)

        }
    }
    
    func chartData() -> ([String],[Double]) {
        guard case .success(let coinDetails) =  state  else { return ([],[])}
        let timeframes = ["24h", "7d", "14d", "30d", "60d", "200d", "1y"]
        let changes = [coinDetails.price_change_percentage_24h,coinDetails.price_change_percentage_7d,coinDetails.price_change_percentage_14d,coinDetails.price_change_percentage_30d,coinDetails.price_change_percentage_60d,coinDetails.price_change_percentage_200d,coinDetails.price_change_percentage_1y]
        
        return (timeframes,changes)

    }
    
    func addToFavoritesToggle() async {
        guard case .success(let coinDetails) =  state  else { return }
        do {
            if !isFav {
                _ = try await favoritesRepository.addCoinToFav(coin: .init(id: coinDetails.id, name: coinDetails.name, symbol: coinDetails.symbol, image: coinDetails.image))
                isFav = true 
            } else {
                _ = try await favoritesRepository.removeCoinFromFav(id: coinDetails.id)
                isFav = false
                
            }
        } catch {
            print("Something went wrong")
        }
    }
    
}
