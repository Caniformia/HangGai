//
//  CustomProgressBar.swift
//  HangGai
//
//  Created by TakiP on 2021/5/30.
//

import SwiftUI

struct CustomProgressBar: View {
    var value: Double

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                        .stroke(colorScheme == .dark ? Color.white : .black)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(colorScheme == .light ? .white : .black)
                Rectangle()
                        .frame(width: min(CGFloat(value) * geometry.size.width, geometry.size.width),
                                height: geometry.size.height)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .opacity(0.8)
            }.cornerRadius(8)
        }
    }
}

struct CircularProgressBar: View {
    var progress: Float

    var body: some View {
        ZStack {
            Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.red)
            Circle()
                    .trim(from: 0, to: CGFloat(min(progress, 1)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear)
        }
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(value: 0.2).frame(height: 15)
    }
}
