//
//  StateMachine.swift
//  CodePracticeProject1_CryptoApp
//
//  Created by Prashant Tukadiya on 28/05/26.
//


protocol MessageError: Error {
    var userFriendlyMessage: String {get }
}


enum StateMachine<T, E: MessageError> {
    case idle
    case loading
    case success(T)
    case failure(E)
}
