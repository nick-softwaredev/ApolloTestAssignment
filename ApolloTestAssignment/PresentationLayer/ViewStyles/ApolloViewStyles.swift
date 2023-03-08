//
//  ApolloViewStyles.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/7/23.
//

import SwiftUI

// MARK: - Button styles.
struct ApolloActionButtonStyle: ButtonStyle {
    
    enum Style {
       case fixed(height: CGFloat, width: CGFloat)
       case dynamic
    }
    
    let style: Style
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: width)
            .frame(height: height)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color(ApolloColors.apolloOrange).opacity(0.5) : Color(ApolloColors.apolloOrange))
            .cornerRadius(18)
    }
    
    var width: CGFloat {
        switch style {
        case .dynamic:
            return .infinity
        case let .fixed(height: _, width: width):
            return width
        }
    }
    
    var height: CGFloat {
        switch style {
        case .dynamic:
            return 60
        case let .fixed(height: height, width: _):
            return height
        }
    }
}

extension UITabBarController {
    //Configure  Global TabBarController, TabBar, TabBarItems appearance
    override open func viewWillLayoutSubviews() {
        let standardAppearance = UITabBarAppearance()
        standardAppearance.backgroundColor = UIColor.black
        standardAppearance.shadowColor = UIColor.black
        tabBar.standardAppearance = standardAppearance
    }
}
