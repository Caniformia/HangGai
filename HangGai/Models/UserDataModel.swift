//
//  UserDataModel.swift
//  HangGai
//
//  Created by roife on 5/13/21.
//

import Foundation

struct questionStatus: CustomStringConvertible {
    var comment: String
    var lastChoices: [Int]
    var incorrectTotalCount: Int
    
    public var description: String {
        return """
            comment: \(comment)
            lastAnswer: \(lastChoices)
            incorrectCount: \(incorrectTotalCount)
            """
    }
}

struct UserDataModel: CustomStringConvertible {
    var favorites: Set<Int>
    var incorrects: Set<Int>
    var questionStatus: [Int:questionStatus]
    
    public var description: String {
        return """
            favorites: \(favorites)
            incorrects: \(incorrects)
            \(questionStatus)
            """
    }
}

extension UserDataModel {
    mutating func updateQuestionComment(questionId: Int, comment: String) {
        self.questionStatus[questionId]?.comment = comment
    }
    
    mutating func updateQuestionChoices(questionId: Int, choices: [Int]) {
        self.questionStatus[questionId]?.lastChoices = choices
    }
}
