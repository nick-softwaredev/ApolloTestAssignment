//
//  ApolloBluetoothScannerTabView.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI

struct ApolloBluetoothScannerTabView: View {
    @ObservedObject var viewModel: ApolloBluetoothScannerViewModel
    
    init(viewModel: ApolloBluetoothScannerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("🛵 LET'S FIND SOME DEVICES! 🛴")
            if let selectedDevice = viewModel.state.selectedDevice {
                /* TODO: show some detailed info view about device
                NavigationLink("", destination:  ) {

                }, isActive: $isPresentingTickets)
                .disabled(true)
                 */
            }
            
            
            Spacer()
            
            
            ScrollView {
                ForEach(viewModel.state.scannedDevices ?? [ApolloScannedBluetoothDevice]()) { device in
                    Text(device.beacon)
                    .onTapGesture {
                        viewModel.perform(action: .selectedDevice(device))
                    }
                }
            }
            
            
            Spacer()
            
            
            Button(viewModel.state.isScanning ? "SCANNING ..." : "SCAN") {
                viewModel.perform(action: viewModel.state.isScanning ? .stopScanning : .startScanning)
            }
        }
        .onDisappear(perform: {
            //viewModel.perform(action: .reetToOriginalState)
        })
        .alert(item: $viewModel.state.bluetoothErorr, content: { error in
            Alert(title: Text("Bluetooth Error"), message: Text(error.shortDescription))
        })
    }
}
