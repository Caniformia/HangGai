//
//  UserDataModel.swift
//  HangGai
//
//  Created by roife on 5/13/21.
//

import Foundation

struct UserQuestionStatus: CustomStringConvertible {
    var comment: String
    var lastChoices: Set<Int>
    var incorrectCount: Int
    
    public var description: String {
        return """
            comment: \(comment)
            lastAnswer: \(lastChoices)
            incorrectCount: \(incorrectCount)
            """
    }
    
    init() {
        self.init(comment: "", lastChoices: Set(), incorrectCount: 0)
    }
    
    init(comment: String, lastChoices: Set<Int>, incorrectCount: Int) {
        self.comment = comment
        self.lastChoices = lastChoices
        self.incorrectCount = incorrectCount
    }
}
