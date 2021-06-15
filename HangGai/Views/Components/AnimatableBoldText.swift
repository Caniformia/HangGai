//
//  AnimatableBoldText.swift
//  HangGai
//
//  Created by bluemond on 2021/6/15.
//

import SwiftUI

struct AnimatableBoldText: View {
    let text: String
    let fontName: String
    let id: Int
    @Binding var selectedId: Int
    let color: Color
    let width: CGFloat
    let kerning: CGFloat
    
    var body: some View {
        ZStack {
            ZStack {
                Text(text).kerning(kerning).offset(x: width / 1000, y: width / 1000)
                Text(text).kerning(kerning).offset(x: -width / 1000, y: -width / 1000)
                Text(text).kerning(kerning).offset(x: -width / 1000, y: width / 1000)
                Text(text).kerning(kerning).offset(x: width / 1000, y: -width / 1000)
            }
                    .foregroundColor(color)
            .animatableFont(name: fontName, size: id == selectedId ? 25.0 : 15.0)
        }
    }
}
