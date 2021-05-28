//
//  DataStorage.swift
//  HangGai
//
//  Created by roife on 5/28/21.
//

import Foundation

struct DataStorage {
    static let standard = UserDefaults.standard
    
    static let favoritesKey = "favorites"
    static let incorrectsKey = "incorrects"
    
    static func saveSet(key: String, set: Set<Int>) {
        standard.set(set, forKey: key)
        standard.synchronize()
    }
    
    static func getSet(key: String) -> Set<Int> {
        guard let data = standard.object(forKey: key) else {
            print("Cannot read \(key)")
            return Set()
        }

        guard let set = data as? Set<Int> else {
            print("Cannot convert data to \(key)")
            return Set()
        }

        return set
    }
    
    private static func questionKey(questionId: Int) -> String {
        return "questionStatus\(questionId)"
    }
    
    static func saveQuestionStatus(questionId: Int, questionStatus: UserQuestionStatus) {
        let key = questionKey(questionId: questionId)
        
        standard.set(questionStatus, forKey: key)
        standard.synchronize()
    }
    
    static func getQuestionStatus(questionId: Int) -> UserQuestionStatus {
        let key = questionKey(questionId: questionId)
        
        guard let data = standard.object(forKey: key) else {
            print("Cannot read \(key)")
            return UserQuestionStatus()
        }

        guard let questionStatus = data as? UserQuestionStatus else {
            print("Cannot convert data to \(key)")
            return UserQuestionStatus()
        }

        return questionStatus
    }
    
    static func saveQuestionStatus(questionStatusDict: [Int:UserQuestionStatus])  {
        questionStatusDict.forEach{ saveQuestionStatus(questionId: $0, questionStatus: $1) }
    }
    
    static func getQuestionStatus() -> [Int:UserQuestionStatus] {
        Dictionary(uniqueKeysWithValues: QuestionIdRange.map { ($0, getQuestionStatus(questionId: $0)) })
    }
}
