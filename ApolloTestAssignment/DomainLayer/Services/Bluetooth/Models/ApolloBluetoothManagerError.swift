//
//  ApolloBluetoothManagerError.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import Foundation

extension ApolloBluetoothService {
    enum ApolloBluetoothManagerError: Error, Identifiable {
        var id: UUID {
            return UUID()
        }
        case unsupported
        case unauthorized
        case unknown
        case resetting
        case poweredOff
        case noDevicesFound // generated manually
        
        var shortDescription: String {
            switch  self {
            case .unsupported:
                return "Bluetooth is unsupported on this device."
            case .poweredOff:
                return "Bluetooth is powered off.\nMake sure to turn it on in Settings."
            case .resetting:
                return "Please wait, Bluetooth is resetting"
            case .unauthorized:
                return "Bluetooth is unauthorized on this device.\nCheck device restriction settings."
            case .unknown:
                return "An unknown Bluetooth error. Please, try again."
            case .noDevicesFound:
                return "No devices found nearby. Please, try again."
            }
        }
    }
}
