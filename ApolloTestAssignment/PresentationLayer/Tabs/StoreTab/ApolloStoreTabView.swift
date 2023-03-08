//
//  ApolloStoreTabView.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/7/23.
//

import SwiftUI

struct ApolloStoreTabView: View {
    @State var servicesActiveIndex = 0
    
    @State var services = [
        ApolloStoreItem(
            type: .service,
            image: "",
            name: "theft and loss",
            title: "Apollo Care + Theft and Loss",
            description: .none,
            priceDescription: "$129 USD or $6.99/mo."
        ),
        ApolloStoreItem(
            type: .service,
            image: "scooterService",
            name: "theft and loss",
            title: "Apollo Care",
            description: .none,
            priceDescription: "$129 USD or $6.99/mo."
        ),
    ]
    @State var accessories = [
        ApolloStoreItem(
            type: .accessorie,
            image: "scooterAccessorie",
            name: .none,
            title: "Apollo Bag",
            description: "Some interesting description here",
            priceDescription: "$19.99 USD."
        )
    ]
    @State var upgrades = [
        ApolloStoreItem(
            type: .upgrade,
            image: "scooter",
            name: .none,
            title: "Phantom V3 Kit",
            description: "At magnum periculum adiit in oculis quidem exercitus quid ex eo delectu rerum.",
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
                    Image(uiImage: UIImage(named: "avatar")!)
                }
                .padding(.bottom, 14)
                ScrollView {
                    sectionView(title: "Apollo Care & Protect", description: "Protect your new scooter")
                    .padding(.bottom, 20)
                    VStack {
                        StoreListView(viewModels: $services, activePageIndex: $servicesActiveIndex, itemWidth: 255, itemPadding: 16, shouldOffset: true)
                    }
                    .background(Color.blue)
                    .frame(height: 330)
                    sectionView(title: "Accessories", description: "Buy new great stuff for your scooter")
                    .padding(.bottom, 20)
                    .padding(.top, 44)
                    VStack {
                       StoreListView(viewModels: $accessories, activePageIndex: $servicesActiveIndex, itemWidth: 255, itemPadding: 16, shouldOffset: true)
                    }
                    .background(Color.blue)
                    .frame(height: 342)
                    sectionView(title: "Upgrades", description: "Hardware & Software Updates")
                    .padding(.bottom, 20)
                    .padding(.top, 44)
                    VStack {
                        StoreListView(viewModels: $upgrades, activePageIndex: $servicesActiveIndex, itemWidth: UIScreen.main.bounds.width - 32, itemPadding: 0, shouldOffset: false)
                    }
                    .background(Color.blue)
                    .frame(height: 406)
                }
            }
        }
        .padding()
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)

    }
    
    @ViewBuilder func sectionView(title: String, description: String) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                Text(description)
                        .foregroundColor(.white)
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

struct StoreListView: View {
    @Binding var viewModels: [ApolloStoreItem]
    @Binding var activePageIndex: Int
    
    let itemWidth: CGFloat
    let itemPadding: CGFloat
    let shouldOffset: Bool
    
    var body: some View {
        VStack {
            Spacer()
            GeometryReader { geometry in
                ApolloPaagedScrollView(
                    activePageIndex: $activePageIndex,
                    itemCount: viewModels.count,
                    pageWidth: geometry.size.width,
                    tileWidth: self.itemWidth,
                    tilePadding: self.itemPadding,
                    stackOffset: shouldOffset ? (-itemPadding * 2 - (itemPadding * 2 - itemPadding / 2 + 2)) : 0
                ) {
                    ForEach(viewModels, id: \.id) { viewModel in
                        ZStack {
                            VStack {
                                if viewModel.type == .upgrade {
                                    Image(viewModel.image)
                                } else {
                                    Image(viewModel.image)
                                        .resizable()
                                        .frame(height: 223)
                                }
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                VStack {
                                    Color(ApolloColors.apolloBorderColor)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 1)
                                        .padding(.bottom)
                                    cardView(item: viewModel)
                                }
                                .padding(.bottom, 18)
                                .background(VisualEffectView(effect: UIBlurEffect(style: .dark)).isHidden(viewModel.type != .upgrade))
                            }
                        }
                        .addBorder(Color(ApolloColors.apolloBorderColor), width: 1, cornerRadius: 16, corners: .allCorners)
                    }
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder func cardView(item: ApolloStoreItem) -> some View {
        switch item.type {
        case .service:
            HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        if let description = item.description {
                            Text(description)
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .light))
                        }
                        if let price = item.priceDescription {
                            Text(price)
                                .foregroundColor(Color(ApolloColors.apolloTextDarkGrayColor))
                                .font(.system(size: 14, weight: .regular))
                        }
                    }
                Spacer()
            }
            .padding(.horizontal)
        case .accessorie:
            HStack(alignment: .center)  {
                VStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        if let description = item.description {
                            Text(description)
                                .foregroundColor(Color(ApolloColors.apolloTextGrayColor))
                                .font(.system(size: 12, weight: .light))
                        }
                    }
                }
                Spacer()
                VStack(spacing: 12) {
                    Button {
                        
                    } label: {
                        Text("Buy")
                    }
                    .buttonStyle(ApolloActionButtonStyle(style: .fixed(height: 29, width: 61)))

                    if let price = item.priceDescription {
                        Text(price)
                            .foregroundColor(Color(ApolloColors.apolloTextDarkGrayColor))
                            .font(.system(size: 12, weight: .light))
                    }
                }
            }
            .padding(.horizontal)
        case .upgrade:
            HStack(alignment: .center)  {
                VStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        if let description = item.description {
                            Text(description)
                                .foregroundColor(Color(ApolloColors.apolloTextGrayColor))
                                .font(.system(size: 12, weight: .light))
                        }
                    }
                }
                Spacer()
                VStack {
                    Button {
                        
                    } label: {
                        Text("Buy")
                    }
                    .buttonStyle(ApolloActionButtonStyle(style: .fixed(height: 29, width: 61)))
                }
            }
            .padding(.bottom, 10)
            .padding(.horizontal)
        }
    }
}
