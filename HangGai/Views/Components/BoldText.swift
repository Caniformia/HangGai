//
//  SwiftUIView.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct BoldText: View {
    let text: String
    let width: CGFloat
    let color: Color
    let size: CGFloat
    let kerning: CGFloat

    var body: some View {
        ZStack{
            ZStack{
                Text(text).font(.custom("FZSSJW--GB1-0", size: size)).kerning(kerning).offset(x:  width/1000, y:  width/1000)
                Text(text).font(.custom("FZSSJW--GB1-0", size: size)).kerning(kerning).offset(x: -width/1000, y: -width/1000)
                Text(text).font(.custom("FZSSJW--GB1-0", size: size)).kerning(kerning).offset(x: -width/1000, y:  width/1000)
                Text(text).font(.custom("FZSSJW--GB1-0", size: size)).kerning(kerning).offset(x:  width/1000, y: -width/1000)
            }
            .foregroundColor(color)
        }
    }
}
