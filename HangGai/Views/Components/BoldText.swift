//
//  SwiftUIView.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct BoldText: View {
    let text: String
    let font: Font
    let color: Color
    let width: CGFloat
    let kerning: CGFloat

    var body: some View {
        Text(text).font(font).kerning(kerning)
                .foregroundColor(color)
    }
}
