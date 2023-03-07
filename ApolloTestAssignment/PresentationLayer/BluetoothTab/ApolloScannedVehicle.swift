//
//  ApolloScannedVehicle.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI

struct ApolloScannedBluetoothDevice: Identifiable {
    let id: UUID = UUID()
    var beacon: String
    var rssi: Int?
    
    func imageForRSSI() -> UIImage {
        guard let safeRSSI = rssi else {
            return #imageLiteral(resourceName: "Vector-6")
        }
        switch safeRSSI {
        case -60 ... 0:
            return UIImage(named: "rssi high") ?? UIImage()
        case -80 ... -61:
            return UIImage(named: "rssi medium") ?? UIImage()
        case -100 ... -81:
            return UIImage(named: "rssi low") ?? UIImage()
        default:
            return UIImage()
        }
    }
}
