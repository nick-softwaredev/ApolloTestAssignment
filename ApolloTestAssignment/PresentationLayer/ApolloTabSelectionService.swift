//
//  ApolloTabSelectionService.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI

final class ApolloTabSelectionService: ObservableObject {
    @Published var selectedTab = 0
    
    enum Tab: Int {
        case bluetoothScanTab = 0
        case store = 1
    }
    
    func select(_ t: Tab) {
        selectedTab = t.rawValue
    }
}
