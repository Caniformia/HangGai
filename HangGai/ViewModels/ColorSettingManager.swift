//
//  ColorSettingManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/30.
//

import Foundation
import SwiftUI

extension Color {
    init(r: Int, g: Int, b: Int) {
        if (r >= 0 && r <= 255) || (g >= 0 && g <= 255) || (b >= 0 && b <= 255) {
            self.init(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0)
        }

        self.init(red: Double(r) / 255.0, green: Double(g) / 255.0, blue: Double(b) / 255.0)
    }

    init(hex: Int) {
        self.init(
                r: (hex >> 16) & 0xFF,
                g: (hex >> 8) & 0xFF,
                b: hex & 0xFF
        )
    }
}

class ColorSetting {
    var bigCorrectMarkColor: [String: Color] = [
        "correctColor": Color(hex: 0x4CAF50),
        "incorrectColor": Color(hex: 0xC03331)
    ]
}

class ColorSettingManager: ObservableObject {
    @Published var currentColorSetting: ColorSetting = ColorSetting()
}
