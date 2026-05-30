//
//  CoinRawView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//



import SwiftUI

struct CoinRawView: View {
    var coin: Coin
    var body: some View {
        HStack(spacing: 8) {
            Text("\(coin.rank)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .frame(width: 32, alignment: .leading)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.2))
            }
            .frame(width: 40,height: 40)
            .clipShape(.circle)

            VStack(alignment: .leading){
                Text(coin.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(coin.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing,spacing: 4) {
                Text(coin.price,format: .currency(code: "USD"))
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(coin.priceChange / 100,format: .percent.sign(strategy: .always()).precision(.fractionLength(2)))
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle( coin.priceChange >= 0 ? .green : .red)
                
            }
            
           
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CoinRawView(coin: Coin(id: "bitcoin", name: "Bitcoin", price: 2515, symbol: "BTC", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png",rank: 100, priceChange: 2))
}
