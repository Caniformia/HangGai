//
//  AnimationSettingManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/30.
//

import Foundation

class AnimationSettingManager {
    private var verifyAnswerDuration: Double = 0.30
    private var verifyAnswerDelay: Double = 0.00

    func getVerifyAnswerDuration() -> Double {
        return self.verifyAnswerDuration
    }

    func getVerifyAnswerDelay() -> Double {
        return self.verifyAnswerDelay
    }
}
