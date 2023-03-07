//
//  ApolloScannedVehiclesViewModelState.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import Foundation

extension ApolloBluetoothScannerViewModel {
    struct ApolloScannedDevicesViewModelState {
        var isScanning: Bool
        var scannedDevices: [ApolloScannedBluetoothDevice] = []
        var selectedDevice: ApolloScannedBluetoothDevice?
        var bluetoothErorr: ApolloBluetoothService.ApolloBluetoothManagerError?
    }
}
