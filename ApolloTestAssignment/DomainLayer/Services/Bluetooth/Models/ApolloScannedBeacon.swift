//
//  ApolloScannedBeacon.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import Foundation

extension ApolloBluetoothService {
    struct ApolloScannedBeacon: Identifiable {
        let id: UUID
        let name: String
        var rssi: Int
    }
}
