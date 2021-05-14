//
//  QuestionModel.swift
//  HangGai
//
//  Created by roife on 5/13/21.
//

import Foundation

protocol Question: CustomStringConvertible {
    var chapter: Int { get }
    var id: Int { get }
    var question: String { get }
    var choices: [String] { get }
    var imgName: String { get }
    
    var description: String { get }
}

struct SingleChoiceQuestion: Question & CustomStringConvertible {
    let id: Int
    let chapter: Int
    let question: String
    let choices: [String]
    let answer: Int
    let imgName: String
    
    public var description: String {
        return """
            id: \(id)
            chapter: \(chapter)
            question: \(question)
            choices: \(choices)
            answer: \(answer)
            imgName: \(imgName)
            """
    }
}

struct MultipleChoiceQuestion: Question & CustomStringConvertible {
    let id: Int
    let chapter: Int
    let question: String
    let choices: [String]
    let answer: [Int]
    let imgName: String
    
    public var description: String {
        return """
            id: \(id)
            chapter: \(chapter)
            question: \(question)
            choices: \(choices)
            answer: \(answer)
            imgName: \(imgName)
            """
    }
}
