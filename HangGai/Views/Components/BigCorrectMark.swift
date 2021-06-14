//
//  BigCorrectMark.swift
//  HangGai
//
//  Created by TakiP on 2021/5/30.
//

import SwiftUI

struct BigCorrectMark: View {
    var correct: Bool

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Circle()
                .foregroundColor(correct ?
                        ColorSettingManager().currentColorSetting.bigCorrectMarkColor["correctColor"] :
                        ColorSettingManager().currentColorSetting.bigCorrectMarkColor["incorrectColor"])
                .frame(width: 150, height: 150, alignment: .center)
                .overlay(Image(systemName: correct ? "checkmark" : "xmark")
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .font(.system(size: 90, weight: .ultraLight)))
    }
}

struct BigCorrectMark_Previews: PreviewProvider {
    static var previews: some View {
        BigCorrectMark(correct: true)
    }
}
