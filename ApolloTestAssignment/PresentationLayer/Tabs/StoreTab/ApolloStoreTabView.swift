//
//  ApolloStoreTabView.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/7/23.
//

import SwiftUI

struct ApolloStoreTabView: View {
    @State var servicesActiveIndex = 0
    @State var accessoriesActiveIndex = 0
    @State var upgradesActiveIndex = 0
    
    @State var services = [
        ApolloStoreItem(
            type: .service,
            image: "scooterServiceNoScooter",
            name: "theft and loss",
            title: "Apollo Care + Theft and Loss",
            description: .none,
            priceDescription: "$129 USD or $6.99/mo"
        ),
        ApolloStoreItem(
            type: .service,
            image: "scooterService",
            name: "theft and loss",
            title: "Apollo Care",
            description: .none,
            priceDescription: "$129 USD or $6.99/mo"
        ),
    ]
    @State var accessories = [
        ApolloStoreItem(
            type: .accessorie,
            image: "scooterAccessorie",
            name: .none,
            title: "Apollo Bag",
            description: "Some interesting description here",
            priceDescription: "$19.99 USD"
        )
    ]
    @State var upgrades = [
        ApolloStoreItem(
            type: .upgrade,
            image: "scooter",
            name: .none,
            title: "Phantom V3 Kit",
            description: "At magnum periculum adiit in oculis quidem exercitus quid ex eo delectu rerum",
            priceDescription: .none
        )
    ]
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    Text("Store")
                        .foregroundColor(Color.white)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    Image(uiImage: UIImage(named: "avatar") ?? UIImage())
                }
                .padding(.bottom, 14)
                ScrollView {
                    sectionView(title: "Apollo Care & Protect", description: "Protect your new scooter")
                    .padding(.bottom, 20)
                    VStack {
                        ApolloStoreListView(viewModels: $services, activePageIndex: $servicesActiveIndex, itemWidth: 255, itemPadding: 16)
                    }
                    .frame(height: 330)
                    sectionView(title: "Accessories", description: "Buy new great stuff for your scooter")
                    .padding(.bottom, 20)
                    .padding(.top, 32)
                    VStack {
                       ApolloStoreListView(viewModels: $accessories, activePageIndex: $accessoriesActiveIndex, itemWidth: 255, itemPadding: 16)
                    }
                    .frame(height: 342)
                    sectionView(title: "Upgrades", description: "Hardware & Software Updates")
                    .padding(.bottom, 20)
                    .padding(.top, 32)
                    VStack {
                        ApolloStoreListView(viewModels: $upgrades, activePageIndex: $upgradesActiveIndex, itemWidth: UIScreen.main.bounds.width - 32, itemPadding: 16)
                    }
                    .frame(height: 406)
                    .padding(.bottom)
                }
            }
        }
        .padding([.leading, .trailing, .top])
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)

    }
    
    @ViewBuilder func sectionView(title: String, description: String) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                Text(description)
                        .foregroundColor(Color(ApolloColors.apolloTextGrayColor))
                        .font(.system(size: 14))
            
            }
            Spacer()
            Button {
                
            } label: {
                Text("See All")
                    .foregroundColor(Color(ApolloColors.apolloBlue))
                    .font(.system(size: 16))
            }
        }
    }
    
}

struct ApolloStoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        ApolloStoreTabView()
    }
}

