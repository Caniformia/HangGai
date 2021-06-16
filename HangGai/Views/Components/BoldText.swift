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
        ZStack {
            ZStack {
                Text(text).font(font).kerning(kerning).offset(x: width / 1000, y: width / 1000).lineSpacing(5)
                Text(text).font(font).kerning(kerning).offset(x: -width / 1000, y: -width / 1000).lineSpacing(5)
                Text(text).font(font).kerning(kerning).offset(x: -width / 1000, y: width / 1000).lineSpacing(5)
                Text(text).font(font).kerning(kerning).offset(x: width / 1000, y: -width / 1000).lineSpacing(5)
            }
                    .foregroundColor(color)
        }
    }
}
