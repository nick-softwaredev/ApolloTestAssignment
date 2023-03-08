//
//  ApolloStoreItem.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/8/23.
//

import Foundation

struct ApolloStoreItem: Identifiable {
    enum ItemType {
        case service
        case upgrade
        case accessorie
    }
    
    let id = UUID()
    let type: ItemType
    let image: String
    let name: String?
    let title: String
    let description: String?
    let priceDescription: String?
}
