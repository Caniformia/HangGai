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
    static let visitedQuestions = "visitedQuestions"
    static let initializedKey = "init"
    static let lastVisitedQuestionIdKey = "lastVisitedQuestionId"

    private static func questionKey(questionId: Int) -> String {
        "questionStatus\(questionId)"
    }

    static func initialize() {
        if !standard.bool(forKey: initializedKey) {
            saveSet(key: favoritesKey, set: Set())
            saveSet(key: incorrectsKey, set: Set())
            saveSet(key: lastVisitedQuestionIdKey, set: Set())
            saveLastVisitedQuestionId(questionId: 1)
            saveQuestionStatus(questionStatusDict: Dictionary(uniqueKeysWithValues: QuestionIdRange.map {
                ($0, UserQuestionStatus())
            }))

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

    static func saveQuestionStatus(questionStatusDict: [Int: UserQuestionStatus]) {
        questionStatusDict.forEach {
            saveQuestionStatus(questionId: $0, questionStatus: $1)
        }
    }

    static func getQuestionStatus() -> [Int: UserQuestionStatus] {
        Dictionary(uniqueKeysWithValues: QuestionIdRange.map {
            ($0, getQuestionStatus(questionId: $0))
        })
    }

    static func getLastVisitedQuestionId() -> Int {
        let questionId = standard.integer(forKey: lastVisitedQuestionIdKey)
        guard questionId != 0 else {
            print("Cannot read \(lastVisitedQuestionIdKey)")
            return 0
        }

        return questionId
    }

    static func saveLastVisitedQuestionId(questionId: Int) {
        standard.setValue(questionId, forKey: lastVisitedQuestionIdKey)
    }

    static func saveInitialize() {
        standard.set(true, forKey: initializedKey)
        standard.synchronize()
    }

    static func getInitialize() -> Bool {
        standard.bool(forKey: initializedKey)
    }
}
