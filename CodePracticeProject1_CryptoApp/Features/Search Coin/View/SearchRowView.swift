//
//  SearchRowView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//

import SwiftUI

struct SearchRowView: View {
    var coin: Coin

    var body: some View {
        HStack(spacing: 12){
           
            
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
            VStack {
                Text("Rank").fontWeight(.bold).font(.caption2)
                Text("\(coin.rank)")
                    .foregroundStyle(.secondary)
                    .font(.caption.bold())
            }
                
        }
    }
}

#Preview {
    SearchRowView(coin: Array<Coin>.testData()[0])
}
