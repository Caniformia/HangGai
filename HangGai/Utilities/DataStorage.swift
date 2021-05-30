//
//  DataStorage.swift
//  HangGai
//
//  Created by roife on 5/28/21.
//

import Foundation

struct DataStorage {
    static let standard = UserDefaults.standard
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static let favoritesKey = "favorites"
    static let incorrectsKey = "incorrects"
    static let initializedKey = "init"
    
    private static func questionKey(questionId: Int) -> String {
        return "questionStatus\(questionId)"
    }
    
    static func initialize() {
        if !standard.bool(forKey: self.initializedKey) {
            saveSet(key: self.favoritesKey, set: Set())
            saveSet(key: self.incorrectsKey, set: Set())
            saveQuestionStatus(questionStatusDict: Dictionary(uniqueKeysWithValues: QuestionIdRange.map { ($0, UserQuestionStatus()) }))
            
            standard.set(true, forKey: self.initializedKey)
            standard.synchronize()
            
            print("Initialize User Data successfully")
        }
    }
    
    static func saveSet(key: String, set: Set<Int>) {
        guard let encodedData = try? encoder.encode(set) else {
            print("Failed to encode \(key) when saving")
            return
        }
        standard.set(encodedData, forKey: key)
        standard.synchronize()
    }
    
    static func getSet(key: String) -> Set<Int> {
        guard let data = standard.object(forKey: key) as? Data else {
            print("Cannot read \(key)")
            return Set()
        }

        guard let set = try? decoder.decode(Set<Int>.self, from: data) else {
            print("Cannot convert data to \(key)")
            return Set()
        }
        
        return set
    }
    
    static func saveQuestionStatus(questionId: Int, questionStatus: UserQuestionStatus) {
        let key = questionKey(questionId: questionId)
        
        guard let encodedData = try? encoder.encode(questionStatus) else {
            print("Failed to encode \(key) when saving")
            return
        }
        
        standard.set(encodedData, forKey: key)
        standard.synchronize()
    }
    
    static func getQuestionStatus(questionId: Int) -> UserQuestionStatus {
        let key = questionKey(questionId: questionId)
        
        guard let data = standard.object(forKey: key) as? Data else {
            print("Cannot read \(key)")
            return UserQuestionStatus()
        }

        guard let questionStatus = try? decoder.decode(UserQuestionStatus.self, from: data) else {
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
