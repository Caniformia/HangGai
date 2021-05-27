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

struct UserDataModel: CustomStringConvertible {
    var favorites: Set<Int>
    var incorrects: Set<Int>
    var questionStatus: [Int:UserQuestionStatus]
    
    public var description: String {
        return """
            favorites: \(favorites)
            incorrects: \(incorrects)
            \(questionStatus)
            """
    }
    
    init() {
        let questionStatus = Dictionary(uniqueKeysWithValues: QuestionIdRange.map { ($0, UserQuestionStatus()) })
        
        self.init(favorites: Set(),
                  incorrects: Set(),
                  questionStatus: questionStatus)
    }
    
    init(favorites: Set<Int>, incorrects: Set<Int>, questionStatus: [Int:UserQuestionStatus]) {
        self.favorites = favorites
        self.incorrects = incorrects
        self.questionStatus = questionStatus
    }
}

extension UserDataModel {
    mutating func updateQuestionComment(questionId: Int, comment: String) {
        guard questionStatus[questionId] != nil else {
            print("Update question comment failed: question ID \(questionId) not found")
            return
        }
        
        self.questionStatus[questionId]!.comment = comment
    }
    
    mutating func updateQuestionChoices(questionId: Int, choices: Set<Int>, isCorrect: Bool) {
        guard questionStatus[questionId] != nil else {
            print("Update question choices failed: question ID \(questionId) not found")
            return
        }
        
        self.questionStatus[questionId]!.lastChoices = choices
        
        if !isCorrect {
            self.questionStatus[questionId]!.incorrectCount += 1
        }
    }
}
