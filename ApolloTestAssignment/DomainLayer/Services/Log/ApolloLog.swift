//
//  ApolloLog.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/8/23.
//

import Foundation

final class ApolloLog {
    static let shared = ApolloLog()
    private let isEnabled: Bool
    
    private init() {
        isEnabled = true
    }
    
    func log(_ message: String) {
        guard isEnabled else {
            return
        }
        print("ApolloDebug 😵‍💫: \(message)")
    }
}
