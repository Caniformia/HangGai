//
//  QuestionModel.swift
//  HangGai
//
//  Created by roife on 5/13/21.
//

import Foundation

let QuestionIdRange = 1...972

enum QuestionType: Int {
    case singleChoice = 1, multipleChoices = 2
}

struct Question: CustomStringConvertible {
    let id: Int
    let chapter: Int
    let questionType: QuestionType
    let questionText: String
    let options: [String]
    let answer: Set<Int>
    let rawImgName: String
    
    var imgName: String {
        String(rawImgName.dropLast(4))
    }
    
    public var description: String {
        return """
            id: \(id)
            chapter: \(chapter)
            question: \(questionText)
            choices: \(options)
            answer: \(answer)
            imgName: \(rawImgName)
            answer: \(answer)
            """
    }
}

extension Question {
    func checkAnswer(choices: Set<Int>) -> Bool {
        return answer == choices
    }
}
