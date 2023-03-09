//
//  ApolloScannedVehicle.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI

struct ApolloScannedBluetoothDevice: Identifiable {
    let id: UUID = UUID()
    var name: String
    var rssi: Int?
    
    func textForRSSI() -> Text {
        guard let safeRSSI = rssi else {
            return Text("")
        }
        switch safeRSSI {
        case -60 ... 0:
            return Text("•••")
                .font(.title)
                .foregroundColor(Color.green)
        case -80 ... -61:
            return Text("•• ")
                .font(.title)
                .foregroundColor(Color.orange)
        case -100 ... -81:
            return Text("•  ")
                .font(.title)
                .foregroundColor(Color.red)
        default:
            return Text("")
        }
    }
}
