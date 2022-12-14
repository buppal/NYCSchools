//
//  Spacing.swift
//  NYSSchools
//
//  Created by Bani Uppal on 12/14/22.
//

import Foundation
import SwiftUI

extension View {
    /// Gives a custom padding, in a more DLS pattern
    func padding(_ edges: Edge.Set = .all, _ spacing: Spacing? = nil) -> some View {
        return self.padding(edges, spacing?.rawValue)
    }
}

enum Spacing: CGFloat {
    case small = 8.0
    case medium = 16.0
}
