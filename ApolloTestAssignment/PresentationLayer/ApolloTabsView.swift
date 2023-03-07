//
//  ContentView.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/6/23.
//

import SwiftUI
import CoreData

struct ApolloTabsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var tabSelectionService: ApolloTabSelectionService
    private let bluetoothService: ApolloBluetoothServiceProtocol

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    init(bluetoothService: ApolloBluetoothServiceProtocol) {
        self.bluetoothService = bluetoothService
    }

    var body: some View {
        TabView(selection: $tabSelectionService.selectedTab, content: {
            NavigationView {
                ApolloBluetoothScannerTabView(viewModel: ApolloBluetoothScannerViewModel(bluetoothService: bluetoothService))
            }
            .tabItem {
                VStack {
                   // Image()  // TODO: add iamge
                    Text("Scan")
                }
            }
            .tag(0)
            NavigationView {
                //TODO: Store goes here.
            }
            .tabItem {
                VStack {
                    //Image()  // TODO: add iamge
                    Text("Store")
                }
            }
            .tag(1)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApolloTabsView(
            bluetoothService: ApolloBluetoothService() //  add mock for testing here ...
        )
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
