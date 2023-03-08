//
//  Extensions.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/7/23.
//

import SwiftUI

// MARK: - View extensions
extension View {
    /// This function hides the view.
    /// hidden - parameter determines if view is visible,
    /// removeFromLayout  - parameter determines if view is removed (removed from view hirerachy layout)
    @ViewBuilder func isHidden(_ hidden: Bool, removeFromLayout: Bool = false) -> some View {
        if hidden {
            if !removeFromLayout {
                self.hidden()
            }
        } else {
            self
        }
    }

    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat, corners: UIRectCorner = UIRectCorner.allCorners) -> some View where S : ShapeStyle {
            let roundedRect = RoundedCorner(radius: cornerRadius, corners: corners) //RoundedRectangle(cornerRadius: cornerRadius)
            return clipShape(roundedRect)
                    .overlay(roundedRect.stroke(content, lineWidth: width))
               //  .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
