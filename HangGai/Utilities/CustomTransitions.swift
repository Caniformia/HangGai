//
//  CustomTransitions.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

extension AnyTransition {
    static var moveOutAndIn: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
                .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
                .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

extension AnyTransition {
    static var moveInAndOut: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
                .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing)
                .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

extension AnyTransition {
    static var expandVertically: AnyTransition {
        let insertion = AnyTransition.move(edge: .top)
                .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .top)
                .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
