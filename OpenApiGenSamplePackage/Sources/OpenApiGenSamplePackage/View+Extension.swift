//
//  File.swift
//  
//
//  Created by Suguru Takahashi on 2024/05/31.
//

import SwiftUI

public extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    ///
    /// - seeAlso: https://stackoverflow.com/questions/56490250/dynamically-hiding-view-in-swiftui
    @ViewBuilder
    func isHidden(_ hidden: Bool, shouldRemove: Bool = false) -> some View {
        if hidden {
            if !shouldRemove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
