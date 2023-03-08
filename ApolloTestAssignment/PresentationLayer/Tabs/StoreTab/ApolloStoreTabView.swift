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
                    .frame(height: 337)
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
        .padding(16)
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

struct ApolloStoreItem: Identifiable {
    enum ItemType {
        case service
        case upgrade
        case accessorie
    }
    
    let id = UUID()
    let type: ItemType
    let image: String
    let name: String?
    let title: String
    let description: String?
    let priceDescription: String?
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
                                .background(Color.yellow)
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
            .padding(.horizontal)
        }
    }
}


public struct ApolloPaagedScrollView: View {
    /// Original implementation source:  https://github.com/izakpavel/SwiftUIPagingScrollView
    public init<Content: View>(activePageIndex: Binding<Int>, itemCount: Int, pageWidth: CGFloat, tileWidth: CGFloat, tilePadding: CGFloat, stackOffset: CGFloat ,@ViewBuilder content: () -> Content) {
        let views = content()
        self.items = [AnyView(views)]
        self._activePageIndex = activePageIndex
        self.pageWidth = pageWidth
        self.tileWidth = tileWidth
        self.tilePadding = tilePadding
        self.tileRemain = (pageWidth - tileWidth - 2 * tilePadding) / 2
        self.itemCount = itemCount
        self.contentWidth = (tileWidth + tilePadding) * CGFloat(self.itemCount)
        self.leadingOffset = tileRemain + tilePadding
        self.stackOffset = stackOffset// -tilePadding / 2 - stackOffset
    }
    /// index of current page 0..N-1
    @Binding var activePageIndex: Int
    
    /// content to display
    private let items: [AnyView]
    
    /// pageWidth==frameWidth used to properly compute offsets
    private let pageWidth: CGFloat
    
    /// width of item / tile
    private let tileWidth: CGFloat
    
    /// padding between items
    private let tilePadding: CGFloat
    
    /// how much of surrounding iems is still visible
    private let tileRemain: CGFloat
    
    /// total width of conatiner
    private let contentWidth: CGFloat
    
    /// offset to scroll on the first item
    private let leadingOffset: CGFloat
    
    /// since the hstack is centered by default this offset actualy moves it entirely to the left
    private let stackOffset: CGFloat // to fix center alignment
    
    /// number of items; I did not come with the soluion of extracting the right count in initializer
    private let itemCount: Int
    
    /// some damping factor to reduce liveness
    private let scrollDampingFactor: CGFloat = 0.66
    
    /// current offset of all items
    @State private var currentScrollOffset: CGFloat = 0
    
    /// drag offset during drag gesture
    @State private var dragOffset: CGFloat = 0
    
    
    private func offsetForPageIndex(_ index: Int) -> CGFloat {
        let activePageOffset = CGFloat(index) * (tileWidth + tilePadding)
        
        return self.leadingOffset - activePageOffset
    }
    
    private func indexPageForOffset(_ offset: CGFloat) -> Int {
        guard self.itemCount > 0 else {
            return 0
        }
        let offset = self.logicalScrollOffset(trueOffset: offset)
        let floatIndex = (offset) / (tileWidth + tilePadding)
        var computedIndex = Int(round(floatIndex))
        computedIndex = max(computedIndex, 0)
        return min(computedIndex, self.itemCount - 1)
    }
    
    /// current scroll offset applied on items
    private func computeCurrentScrollOffset() -> CGFloat {
        return self.offsetForPageIndex(self.activePageIndex) + self.dragOffset
    }
    
    /// logical offset startin at 0 for the first item - this makes computing the page index easier
    private func logicalScrollOffset(trueOffset: CGFloat) -> CGFloat {
        return (trueOffset - leadingOffset) * -1.0
    }
    
   
    public var body: some View {
        GeometryReader { _ in
            HStack(alignment: .center, spacing: self.tilePadding) {
                /// building items into HStack
                ForEach(0..<self.items.count, id: \.self) { index in
                    self.items[index]
                        .frame(width: self.tileWidth)
                }
            }
            .onAppear {
                self.currentScrollOffset = self.offsetForPageIndex(self.activePageIndex)
            }
            .offset(x: self.stackOffset, y: 0)
            .background(Color.black.opacity(0.00001)) // hack - this allows gesture recognizing even when background is transparent
            .frame(width: self.contentWidth)
            .offset(x: self.currentScrollOffset, y: 0)
            .simultaneousGesture( DragGesture(minimumDistance: 1, coordinateSpace: .local) // can be changed to simultaneous gesture to work with buttons
                .onChanged { value in
                    self.dragOffset = value.translation.width
                    self.currentScrollOffset = self.computeCurrentScrollOffset()
                }
                .onEnded { value in
                    // compute nearest index
                    let velocityDiff = (value.predictedEndTranslation.width - self.dragOffset) * self.scrollDampingFactor
                    let newPageIndex = self.indexPageForOffset(self.currentScrollOffset + velocityDiff)
                    self.dragOffset = 0
                    withAnimation {
                        self.activePageIndex = newPageIndex
                        self.currentScrollOffset = self.computeCurrentScrollOffset()
                    }
                }
            )
        }
    }
}
