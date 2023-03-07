//
//  Apolo.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import Foundation

extension ApolloBluetoothScannerViewModel {
    enum ApolloBeaconsViewModelAction {
        case startScanning
        case stopScanning
        case selectedDevice(ApolloScannedBluetoothDevice)
        case deselectDevice
        case reetToOriginalState
    }
}
