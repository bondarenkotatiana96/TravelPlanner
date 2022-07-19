//
//  IsHidden.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/19/22.
//

import SwiftUI


extension View {
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
}
private struct HiddenModifier: ViewModifier {
    private let isHidden: Bool
    private let remove: Bool
    init(isHidden: Bool, remove: Bool = false) {
        self.isHidden = isHidden
        self.remove = remove
    }
    func body(content: Content) -> some View {
        Group {
            if isHidden {
                if remove {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}
