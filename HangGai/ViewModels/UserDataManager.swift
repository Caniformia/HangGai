//
//  LocalDataManager.swift
//  HangGai
//
//  Created by roife on 2021/5/15.
//

import Foundation

class UserDataManager: ObservableObject {
    @Published var favorites: Set<Int>
    @Published var incorrects: Set<Int>
    @Published var visitedQuestions: Set<Int>

    @Published var isFavoritesEmpty: Bool
    @Published var isIncorrectsEmpty: Bool

    private var questionStatus: [Int: UserQuestionStatus]

    init() {
        DataStorage.initialize()
        favorites = DataStorage.getSet(key: DataStorage.favoritesKey)
        incorrects = DataStorage.getSet(key: DataStorage.incorrectsKey)
        questionStatus = DataStorage.getQuestionStatus()
        visitedQuestions = DataStorage.getSet(key: DataStorage.visitedQuestions)
        isFavoritesEmpty = DataStorage.getSet(key: DataStorage.favoritesKey).isEmpty
        isIncorrectsEmpty = DataStorage.getSet(key: DataStorage.incorrectsKey).isEmpty
    }

    // TODO
    func getFavorites() -> Set<Int> {
        favorites = DataStorage.getSet(key: DataStorage.favoritesKey)
        return favorites
    }

    // TODO
    func getIncorrects() -> Set<Int> {
        incorrects = DataStorage.getSet(key: DataStorage.incorrectsKey)
        return incorrects
    }

    func getVisitedQuestions() -> Set<Int> {
        visitedQuestions = DataStorage.getSet(key: DataStorage.lastVisitedQuestionIdKey)
        return visitedQuestions
    }

    func toggleFavorite(questionId: Int) {
        if favorites.contains(questionId) {
            favorites.remove(questionId)
        } else {
            favorites.insert(questionId)
        }

        DataStorage.saveSet(key: DataStorage.favoritesKey, set: favorites)
    }

    // TODO
    func updateIncorrects(questionId: Int, isCorrect: Bool) {
        if isCorrect && incorrects.contains(questionId) {
            incorrects.remove(questionId)
        } else if !isCorrect && !incorrects.contains(questionId) {
            incorrects.insert(questionId)
        }
        DataStorage.saveSet(key: DataStorage.incorrectsKey, set: incorrects)
        incorrects = DataStorage.getSet(key: DataStorage.incorrectsKey)
        isIncorrectsEmpty = incorrects.isEmpty
    }

    func toggleIncorrects(questionId: Int) {
        if incorrects.contains(questionId) {
            incorrects.remove(questionId)
        } else {
            incorrects.insert(questionId)
        }
        DataStorage.saveSet(key: DataStorage.incorrectsKey, set: incorrects)
    }

    func getQuestionComment(questionId: Int) -> String? {
        guard questionStatus[questionId] != nil else {
            print("Get question comment failed: question ID \(questionId) not found")
            return nil
        }

        return questionStatus[questionId]!.comment
    }

    func updateQuestionComment(questionId: Int, comment: String) {
        guard questionStatus[questionId] != nil else {
            print("Update question comment failed: question ID \(questionId) not found")
            return
        }

        questionStatus[questionId]!.comment = comment
        DataStorage.saveQuestionStatus(questionId: questionId,
                questionStatus: questionStatus[questionId]!)
    }

    func getQuestionChoices(questionId: Int) -> Set<Int>? {
        guard questionStatus[questionId] != nil else {
            print("Get question choices failed: question ID \(questionId) not found")
            return nil
        }

        return questionStatus[questionId]!.lastChoices
    }

    func updateQuestionChoices(questionId: Int, choices: Set<Int>, isCorrect: Bool) {
        guard questionStatus[questionId] != nil else {
            print("Update question choices failed: question ID \(questionId) not found")
            return
        }

        questionStatus[questionId]!.lastChoices = choices

        if !isCorrect {
            questionStatus[questionId]!.incorrectCount += 1
        }

        DataStorage.saveQuestionStatus(questionId: questionId,
                questionStatus: questionStatus[questionId]!)
    }

    func getQuestionIncorrectCount(questionId: Int) -> Int? {
        guard questionStatus[questionId] != nil else {
            print("Update question choices failed: question ID \(questionId) not found")
            return nil
        }

        return questionStatus[questionId]!.incorrectCount
    }

    func getIncorrectsCountList() -> [(Int, Int)] {
        questionStatus.map {
            ($1.incorrectCount, $0)
        }.sorted {
            $0.0 != $1.0 ? $0.0 > $1.0 : $0.1 < $1.1
        }
    }

    func updateLastVisitedQuestionId(questionId: Int) {
        DataStorage.saveLastVisitedQuestionId(questionId: questionId)
    }

    func getLastVisitedQuestionId() -> Int {
        DataStorage.getLastVisitedQuestionId()
    }

    func addVisitedQuestions(questionId: Int) {
        visitedQuestions.insert(questionId)
        DataStorage.saveSet(key: DataStorage.visitedQuestions, set: visitedQuestions)
    }

    func isInitialized() -> Bool {
        DataStorage.getInitialize()
    }

    func setInitialized() {
        DataStorage.saveInitialize()
    }
}
