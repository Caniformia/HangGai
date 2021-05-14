//
//  DataStorage.swift
//  HangGai
//
//  Created by roife on 5/14/21.
//

import Foundation
import SQLite3

public struct QuestionLoader {
    static let path = Bundle.main.path(forResource: "questions", ofType: "db")
    static let tableName = "science_questions";
    
    private enum ColumnIndex: Int32 {
        case id = 0, question = 1, optionA = 2, optionB = 3, optionC = 4, optionD = 5, answer = 7, type = 8, chapter = 9, imgName = 11
    }
    
    private enum questionType: Int {
        case singleChoice = 1, multipleChoices = 2
    }
        
    private static func openDB() -> OpaquePointer? {
        guard let path = path else {
            print("Cannot find DB from the path")
            return nil
        }

        var db: OpaquePointer?

        if sqlite3_open(path, &db) == SQLITE_OK {
            print("Successfully open DB at \(path)")
            return db
        } else {
            print("Fail to open DB at \(path)")
            return nil
        }
    }
    
    private static func closeDB(db: OpaquePointer) {
        sqlite3_close(db)
    }
    
    static func loadQuestions() -> [Question]? {
        let queryStatementString = "SELECT * FROM \(tableName);"
        var queryStatement: OpaquePointer?
        
        guard let db = openDB() else {
            return nil
        }
        
        guard sqlite3_prepare(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK else {
            print("Query of DB is not prepared")
            return nil
        }
        
        var questions: [Question] = []
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let id = Int(sqlite3_column_int(queryStatement, ColumnIndex.id.rawValue))
            let question = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.question.rawValue))
            
            let optionA = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.optionA.rawValue))
            let optionB = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.optionB.rawValue))
            let optionC = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.optionC.rawValue))
            let optionD = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.optionD.rawValue))
            let answerText = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.answer.rawValue))
            
            let type = Int(sqlite3_column_int(queryStatement, ColumnIndex.type.rawValue))
            let chapter = Int(sqlite3_column_int(queryStatement, ColumnIndex.chapter.rawValue))
            let imgName = String(cString: sqlite3_column_text(queryStatement, ColumnIndex.imgName.rawValue))
            
            let answerIndexDict = ["A": 0, "B": 1, "C": 2, "D": 3]
            
            if type == questionType.singleChoice.rawValue {
                guard let answer = answerIndexDict[answerText] else {
                    print("Dictionary does not contain the answer (\(answerText)) of question (id: \(id))")
                    return nil
                }
                
                let singleChoiceQuestion = SingleChoiceQuestion(id: id,
                                                                chapter: chapter,
                                                                question: question,
                                                                choices: [optionA, optionB, optionC, optionD],
                                                                answer: answer,
                                                                imgName: imgName)
                questions.append(singleChoiceQuestion)
            } else {
                let answer = answerText.split(separator: "-").map{ answerIndexDict[String($0)] }
                guard !answer.contains(nil) else {
                    print("Dictionary does not contain the answer (\(answerText)) of question (id: \(id))")
                    return nil
                }
                
                let multipleChoiceQuestion = MultipleChoiceQuestion(id: id,
                                                                    chapter: chapter,
                                                                    question: question,
                                                                    choices: [optionA, optionB, optionC, optionD],
                                                                    answer: answer.compactMap{ $0 },
                                                                    imgName: imgName)
                questions.append(multipleChoiceQuestion)
            }
        }
        
        sqlite3_finalize(queryStatement)
    
        #if DEBUG
            print(questions)
        #endif
        
        return questions
    }
}
