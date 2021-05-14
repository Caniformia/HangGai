//
//  UserDataModel.swift
//  HangGai
//
//  Created by roife on 5/13/21.
//

import Foundation

struct UserQuestionInfo: CustomStringConvertible {
    var comment: String
    var lastAnswer: [Int]
    var incorrectCount: Int
    
    public var description: String {
        return """
            comment: \(comment)
            lastAnswer: \(lastAnswer)
            incorrectCount: \(incorrectCount)
            """
    }
}

struct UserDataModel: CustomStringConvertible {
    var favorites: Set<Int>
    var incorrects: Set<Int>
    var questionStatus: [Int:UserQuestionInfo]
    
    public var description: String {
        return """
            favorites: \(favorites)
            incorrects: \(incorrects)
            \(questionStatus)
            """
    }
}
