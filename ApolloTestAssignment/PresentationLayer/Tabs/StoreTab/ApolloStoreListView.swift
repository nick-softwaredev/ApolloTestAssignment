//
//  ApolloStoreListView.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/8/23.
//

import SwiftUI

struct ApolloStoreListView: View {
    @Binding var viewModels: [ApolloStoreItem]
    @Binding var activePageIndex: Int
    
    let itemWidth: CGFloat
    let itemPadding: CGFloat
    let shouldOffset: Bool
    
    var body: some View {
        VStack {
            Spacer()
            GeometryReader { geometry in
                ApolloPagedScrollView(
                    activePageIndex: $activePageIndex,
                    itemCount: viewModels.count,
                    pageWidth: geometry.size.width,
                    tileWidth: self.itemWidth,
                    tilePadding: self.itemPadding,
                    stackOffset: 0
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
