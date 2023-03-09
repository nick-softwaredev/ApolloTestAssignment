//
//  ApolloBluetoothScannerTabView.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI

struct ApolloBluetoothScannerTabView: View {
    @ObservedObject var viewModel: ApolloBluetoothScannerViewModel
    @State private var rotationValue: CGFloat = 0
    @State private var rotationValue2: CGFloat = 0
    
    init(viewModel: ApolloBluetoothScannerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(ApolloColors.apolloOrange).opacity(0.5), Color.black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                /* TODO: show some detailed info view about device
                 if let selectedDevice = viewModel.state.selectedDevice {
                 NavigationLink("", destination:  EmptyView()) {
                 
                 }, isActive: $isPresentinDevice
                 .disabled(true)
                 }
                 */
                Spacer()
                scannedDevicesListView
                Spacer()
                bottomView
                // seemless border with tabbar hack :)
                    .frame(width: UIScreen.main.bounds.width + 2)
                    .addBorder(Color(ApolloColors.apolloBorderColor), cornerRadius: 16, corners: [.topLeft, .topRight])
                    .overlay(
                        VStack {
                            Spacer()
                            Color.black
                                .frame(height: 10)
                        }
                            .offset(y: 2)
                    )
            }
            .onDisappear(perform: {
                viewModel.perform(action: .reetToOriginalState)
            })
            .alert(item: $viewModel.state.bluetoothErorr, content: { error in
                Alert(title: Text("Bluetooth Error"), message: Text(error.shortDescription))
            })
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder var scannedDevicesListView: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("✨")
                        .font(.system(size: 50))
                    Text("🛴")
                        .font(.system(size: 150))
                    Text("🎉")
                        .font(.system(size: 50))
                }
            }
            .padding(.bottom)
            HStack {
                Text("Found devices:")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular))
                    .isHidden((viewModel.state.scannedDevices.isEmpty))
                Spacer()
            }
            .padding(.horizontal)
            Divider()
                .background(Color(ApolloColors.apolloBorderColor))
                .isHidden((viewModel.state.scannedDevices.isEmpty))
            ForEach(viewModel.state.scannedDevices) { device in
                scannedDeviceRowView(device)
                    .padding(.horizontal)
                Divider()
                    .background(Color(ApolloColors.apolloBorderColor))
            }
        }
        .disabled(viewModel.state.scannedDevices.isEmpty)
    }
    
    @ViewBuilder func scannedDeviceRowView(_ device: ApolloScannedBluetoothDevice) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(device.name)
                    .foregroundColor(Color(ApolloColors.apolloTextGrayColor))
                    .font(.system(size: 14, weight: .light))
                Spacer()
                device.textForRSSI()
                Image(uiImage: UIImage(named: "arrowRight") ?? UIImage())
                    .opacity(0.75)
            }
            .padding(.bottom, 8)
        }
        .onTapGesture {
            viewModel.perform(action: .selectedDevice(device))
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) { }
        }
    }
    
    @ViewBuilder var bottomView: some View {
        VStack {
            Button {
                viewModel.perform(action: viewModel.state.isScanning ? .stopScanning : .startScanning)
            } label: {
                if viewModel.state.isScanning {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.75)
                            .stroke(.white, lineWidth: 2)
                            .background(Color.clear)
                            .frame(width: 36, height: 36)
                            .rotationEffect(Angle.degrees(rotationValue))
                            .onAppear {
                                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                                    guard rotationValue < CGFloat.greatestFiniteMagnitude else {
                                        rotationValue = 0
                                        return
                                    }
                                    rotationValue += 360
                                }
                            }
                        Circle()
                            .trim(from: 0, to: 0.75)
                            .stroke(.black, lineWidth: 2)
                            .background(Color.clear)
                            .frame(width: 25, height: 25)
                            .rotationEffect(Angle.degrees(rotationValue2))
                            .onAppear {
                                withAnimation(.linear(duration: 1).speed(0.5).repeatForever(autoreverses: false)) {
                                    guard rotationValue2 < CGFloat.greatestFiniteMagnitude else {
                                        rotationValue2 = 0
                                        return
                                    }
                                    rotationValue2 += 360
                                }
                            }
                    }
                } else {
                    Text("SCAN")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(ApolloActionButtonStyle(style: .dynamic))
            .padding(.vertical, 32)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .cornerRadius(16)
    }
}

struct ApolloBluetoothScannerTabView_Previews: PreviewProvider {
    static var previews: some View {
        ApolloBluetoothScannerTabView(viewModel: ApolloBluetoothScannerViewModel(bluetoothService: ApolloBluetoothService()))
    }
}



