//
//  ApolloBluetoothScannerViewModel.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI
import Combine

protocol ApolloBluetoothScannerViewModelProtocol: ObservableObject {
    var state: ApolloBluetoothScannerViewModel.ApolloScannedDevicesViewModelState { get set }
    func perform(action: ApolloBluetoothScannerViewModel.ApolloScannedDevicesViewModelAction)
}

final class ApolloBluetoothScannerViewModel: ApolloBluetoothScannerViewModelProtocol {
    private let bluetoothService: ApolloBluetoothServiceProtocol
    private var bluetoothManagerCancellable: AnyCancellable?
    private var timerCancellable: Cancellable?
    private let bluetoothScanTimer = Timer.publish(every: ApolloBluetoothService.bluetoothScanSecondsTimer, on: .main, in: .default).autoconnect() // stop scan after timer
    
    @Published var state: ApolloScannedDevicesViewModelState = ApolloScannedDevicesViewModelState(isScanning: false, scannedDevices: [], selectedDevice: .none, bluetoothErorr: .none)
    
    init(bluetoothService: ApolloBluetoothServiceProtocol) {
        self.bluetoothService = bluetoothService
    }
    
    func perform(action: ApolloScannedDevicesViewModelAction) {
        switch action {
        case .startScanning:
            state = ApolloScannedDevicesViewModelState(isScanning: true, scannedDevices: [], selectedDevice: .none, bluetoothErorr: .none)
            timerCancellable = bluetoothScanTimer.sink { [weak self ] _ in
                guard let self = self else { return }
                print("BLE SCANNING TIMED OUT: Scanning sstoped")
                self.perform(action: .stopScanning)
                if self.state.scannedDevices.isEmpty {
                    self.state.bluetoothErorr = .noDevicesFound
                }
            }
            setupDeviceScanning()
            bluetoothService.startScanningForBeacons()
        case .stopScanning:
            stopScanProcess()
        case .selectedDevice(let v):
            state.selectedDevice = v
        case .deselectDevice:
            state.selectedDevice = .none
        case .reetToOriginalState:
            perform(action: .stopScanning)
            state = ApolloScannedDevicesViewModelState(isScanning: false, scannedDevices: [], selectedDevice: .none, bluetoothErorr: .none)
        }
    }
    
    private func setupDeviceScanning() {
        bluetoothManagerCancellable = bluetoothService.result
            .subscribe(on: DispatchQueue(label: ApolloConcurencyServiceQueuIndetifiers.bluetoothScanningQueue, qos: .userInteractive))
            .delay(for: 2, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { bleManagerError in
                switch bleManagerError {
                case .failure(let e):
                    self.state.bluetoothErorr = e
                    self.stopScanProcess()
                case .finished:
                    print("ble cancel finished")
                }
            }, receiveValue: { [weak self] scannedBeaconNames in
                var devices = [ApolloScannedBluetoothDevice]()
                scannedBeaconNames.forEach { beacon in
                    devices.append(ApolloScannedBluetoothDevice(name: beacon.name, rssi: beacon.rssi))
                }
                self?.state.scannedDevices = devices.sorted { $0.rssi ?? Int() > $1.rssi ?? Int() } // filter by RSSI signal strenght.
            })
    }
    
    private func stopScanProcess() {
        bluetoothService.stopScanningForBeacons()
        removeDeviceScanning()
        state.isScanning = false
    }
    
    private func removeDeviceScanning() {
        self.timerCancellable?.cancel()
        self.timerCancellable = nil
        self.bluetoothManagerCancellable?.cancel()
        self.bluetoothManagerCancellable = nil
    }
}
