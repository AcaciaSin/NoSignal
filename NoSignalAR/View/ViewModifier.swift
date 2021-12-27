//
//  ViewModifier.swift
//  NoSignal
//
//  Created by student9 on 2021/12/24.
//

import SwiftUI

struct NEUShadow: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    let radius: CGFloat
    let offset: CGFloat
    init(radius: CGFloat = 10, offset: CGFloat = 10) {
        self.radius  = radius
        self.offset = offset
    }
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.white.opacity(colorScheme == .light ? 1 : 0.25),
                    radius: radius,
                    x: -offset, y: -offset)
            .shadow(color: Color.black.opacity(colorScheme == .light ? 0.25 : 0.5), radius: radius, x: offset, y: offset)
    }
}
