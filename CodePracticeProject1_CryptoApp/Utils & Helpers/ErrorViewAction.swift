//
//  ErrorViewAction.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 29/05/26.
//
import SwiftUI

struct ErrorViewAction: View {
    var title: String
    var message: String
    var systemImage: String
    var action:  () async -> Void
    var body: some View {
        
        ContentUnavailableView {
            VStack {
                Image(systemName: systemImage)
                    .font(.system(size: 150))
                Text(title)
            }
                
        } description: {
            Text(message)
        } actions: {
            Button {
                Task {
                    await action()
                }
            } label: {
                Text("Retry")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.vertical,8)
            }
            .tint(.primary)
            .buttonStyle(.borderedProminent)
            
        }
    }
}
