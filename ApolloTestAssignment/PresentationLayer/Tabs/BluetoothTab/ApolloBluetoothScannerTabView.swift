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
            LinearGradient(colors: [Color(ApolloColors.apolloOrange), Color.black], startPoint: .top, endPoint: .bottom)
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
            Color.gray
                .opacity(0.5)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .isHidden((viewModel.state.scannedDevices.isEmpty))
            ForEach(viewModel.state.scannedDevices) { device in
                VStack(spacing: 0) {
                    HStack {
                        Text(device.beacon)
                            .foregroundColor(.white.opacity(0.75))
                            .padding()
                        Spacer()
                        device.textForRSSI()
                        Image(uiImage: UIImage(named: "arrowRight") ?? UIImage())
                            .opacity(0.75)
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
                    Color.gray
                        .opacity(0.5)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                }
                .onTapGesture {
                    viewModel.perform(action: .selectedDevice(device))
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) { }
                }
            }
        }
        .disabled(viewModel.state.scannedDevices.isEmpty)
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
                            .stroke(.gray, lineWidth: 2)
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
            .padding(32)
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



