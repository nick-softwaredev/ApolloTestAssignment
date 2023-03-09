//
//  ApolloBluetoothService.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import CoreBluetooth
import Combine
import SwiftUI

protocol ApolloBluetoothServiceProtocol: CBCentralManagerDelegate {
    func startScanningForBeacons()
    func stopScanningForBeacons()
    var result: PassthroughSubject<[ApolloBluetoothService.ApolloScannedBeacon] ,ApolloBluetoothService.ApolloBluetoothManagerError> { get set }
}

final class ApolloBluetoothService: NSObject, ApolloBluetoothServiceProtocol {
    
    static let bluetoothScanSecondsTimer: TimeInterval = 30
    
    private var manager = CBCentralManager()
    private var bleState: CBManagerState = .unknown
    private var foundPeripherals: [ApolloScannedBeacon] = []
    private var ignoresUnnamedDevices = true
    
    var result: PassthroughSubject<[ApolloScannedBeacon] ,ApolloBluetoothManagerError> = PassthroughSubject<[ApolloScannedBeacon],ApolloBluetoothManagerError>()
    
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    func startScanningForBeacons() {
        ApolloLog.shared.log("Bluetooth did update state: \(bleState).")
        switch (bleState) {
        case .unsupported:
            result.send(completion: .failure(.unsupported))
            break
        case .unauthorized:
            result.send(completion: .failure(.unauthorized))
            break
        case .unknown:
            result.send(completion: .failure(.unknown))
            break
        case .resetting:
            result.send(completion: .failure(.resetting))
            break
        case .poweredOff:
            result.send(completion: .failure(.poweredOff))
            break
        case .poweredOn:
            manager.scanForPeripherals(withServices: nil, options: nil)
        @unknown default:
            ApolloLog.shared.log("Bluetooth state is in uknonw state.")
        }
    }
    
    func stopScanningForBeacons() {
        manager.stopScan()
        foundPeripherals.removeAll()
        result = PassthroughSubject<[ApolloScannedBeacon],ApolloBluetoothManagerError>()
    }
    
    //MARK: - CBCentralManagerDelegate
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        ApolloLog.shared.log("Bluetooth did found peripheral: \(peripheral.name ?? "Unknown Name") with RSSI \(RSSI.intValue).")
        if ignoresUnnamedDevices {
            guard peripheral.name != .none else {
                return
            }
            updateFoundPeriherals(peripheral, RSSI)
        } else {
            updateFoundPeriherals(peripheral, RSSI)
        }
        result.send(foundPeripherals)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        bleState = central.state
    }
    
    //MARK: Helper funcs.
    private func updateFoundPeriherals(_ peripheral: CBPeripheral, _ RSSI: NSNumber) {
        // if already added to found peripherals, only update rssi level.
        if foundPeripherals.contains(where: { $0.id == peripheral.identifier }) {
            if let index = foundPeripherals.firstIndex(where: { $0.id == peripheral.identifier}) {
                foundPeripherals[index].rssi = RSSI.intValue
            }
        } else {
            foundPeripherals.append(ApolloScannedBeacon(id: peripheral.identifier, name: peripheral.name ?? "Unnamed Device 😢", rssi: RSSI.intValue))
        }
    }
}
