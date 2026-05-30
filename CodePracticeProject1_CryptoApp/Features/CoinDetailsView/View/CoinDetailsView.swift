//
//  CoinDetailsView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//

import SwiftUI
import Charts

let tempurl = "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png"

let timeframes = ["24h", "7d", "14d", "30d", "60d", "200d", "1y"]
let changes = [0.32861, -4.73705, -8.77157, -4.51946, 8.77089, -30.61233, -32.13439]
struct CoinDetailsView: View {
    
    @State private var expandMore = false
    let id:String
    let vm =  CoinDetailsFactory.makeViewModel()
    
    init(id: String) {
        self.id = id
    }
    
    var body: some View {
        Group {
            switch vm.state {
            case .idle,.loading:
                ProgressView("Please wait")
            case .failure(let error):
                ErrorViewAction(title: error.userFriendlyMessage, message: "Something went wrong, Please wait and try again", systemImage: "wifi.exclamationmark") {
                        await vm.fetchCoinDetails(id: id)
                }
            case .success(let coin):
                
                ScrollView {
                    VStack {
                        headerView(coin)
                        livePriceView(coin)
                        chartPriceChange(coin)
                        marketStatus(coin)
                        coinDetails(coin)
                    }
                    .navigationTitle(coin.name.uppercased())
                    .navigationBarTitleDisplayMode(.inline)
                    .padding()
                    .toolbar {
                        Button("Favorite", systemImage: "heart") {
                            
                        }
                        .tint(.pink)
                        .buttonStyle(.glass)
                    }
                }
            }
        }.task(id: id) {
            await vm.fetchCoinDetails(id: id)
        }
    }
    
    func headerView(_ coin: CoinDetails) -> some View {
        VStack(alignment: .leading) {
            
            HStack {
                AsyncImage(url: URL(string: coin.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Circle()
                        .fill(.gray)
                }
                .frame(height: 60)
//                .clipShape(.circle)
                .background(.red,in: .circle)
                
                Text(coin.name)
                    .font(.title)
                    .fontWeight(.medium)
                Text("(\(coin.symbol))")
                    .font(.title2)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
        
    }
    func livePriceView(_ coin: CoinDetails) -> some View {
        VStack(alignment: .leading) {
            Text("Live Price")
                .font(.caption)
                .foregroundStyle(.gray)
            HStack {
                Text(coin.current_price,format: .currency(code: "USD"))
                    .font(.title2.bold())
                    .monospaced()
                
                Text(coin.price_change_percentage_24h / 100,format: .percent.sign(strategy: .always()).precision(.fractionLength(2)))
                    .foregroundStyle(.green)
                    .font(.caption.monospaced())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical,8)
    }
    func marketStatus(_ coin: CoinDetails) -> some View {
        VStack {
            HStack {
                marketStatusCardView(title: "Market cap", value: 2151313513515)
                marketStatusCardView(title: "24h Volume", value: 21513511311)

            }
            HStack {
                marketStatusCardView(title: "All time high", value: 73548)
                marketStatusCardView(title: "All time low", value: 12)

            }
        }
    }
    
    func marketStatusCardView(title :String, value: Double) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(.gray)
            Spacer()
            Text(value,format: .currency(code: "USD").notation(.compactName))
                .font(.headline)
                .monospacedDigit()

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.teal.secondary.opacity(0.4),in: .rect(cornerRadius: 12))
    }
    
    func chartPriceChange(_ coin: CoinDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Price Change by Timeframe")
                .font(.headline)
            
            Chart {
                ForEach(timeframes.enumerated(), id:\.offset) { id in
                    BarMark(x: .value("Timeframe",id.element),y: .value("Change in %", changes[id.offset]))
                        .foregroundStyle(changes[id.offset] > 0 ? .green : .red)
                }
                
            }
            .foregroundStyle(.teal.tertiary)
            .chartXAxisLabel("Timeframe")
            .chartYAxisLabel("Change in %")

        }
        .frame(height: 220)
        .padding(.vertical)
    }
    
    func coinDetails(_ coin: CoinDetails) -> some View {
        VStack(alignment: .leading,spacing: 20) {
            Text("About")
                .font(.callout)
                .fontWeight(.semibold)
            HStack(alignment: .lastTextBaseline, spacing:0) {
                Text(coin.description)
                    .lineLimit(expandMore ? nil : 4)
                    .font(.footnote)
                Button(expandMore ? "less" : "more") {
                    withAnimation {
                        expandMore.toggle()
                    }
                }
            }
            .font(.footnote)

            
        }
        .padding(.vertical)
    }
    
}


#Preview {
    NavigationStack {
        CoinDetailsView(id: "bitcoin")
    }
    
    
}

