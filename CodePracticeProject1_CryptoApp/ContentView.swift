//
//  ContentView.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var errormsg = ""
    @State private var coins = [CointDTO]()

    var body: some View {
        ScrollView {
            LazyVStack {
                Text(errormsg)
                Button("Load Data") {
                    Task {
                        await loadData()
                    }
                }
                ForEach(coins) { coin in
                    Text(coin.name)
                }
            }
        }
        .task {
           
        }
    }
   
    func loadData() async {
        do {
            let apiBase = ApiClient()
            coins =  try await apiBase.sendRequest(endPoint: EndPoint.coinList)
            
        } catch {
            errormsg = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
