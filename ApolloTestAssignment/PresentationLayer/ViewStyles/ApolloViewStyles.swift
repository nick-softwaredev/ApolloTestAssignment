//
//  ApolloViewStyles.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/7/23.
//

import SwiftUI

// MARK: - Button styles.
struct ApolloActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color(ApolloColors.apolloOrange).opacity(0.5) : Color(ApolloColors.apolloOrange))
            .cornerRadius(10)
    }
}

