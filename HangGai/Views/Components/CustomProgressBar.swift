//
//  CustomProgressBar.swift
//  HangGai
//
//  Created by TakiP on 2021/5/30.
//

import SwiftUI

struct CustomProgressBar: View {
    var value: Double
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black)
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.white)
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.black)
                    .animation(.linear)
                    .opacity(0.8)
            }.cornerRadius(8)
        }
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(value: 0.2).frame(height: 15)
    }
}
