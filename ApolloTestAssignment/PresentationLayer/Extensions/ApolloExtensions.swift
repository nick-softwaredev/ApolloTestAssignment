//
//  Extensions.swift
//  ApolloTestAssignment
//
//  Created by Nick Nick  on 3/7/23.
//

import SwiftUI

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
}
