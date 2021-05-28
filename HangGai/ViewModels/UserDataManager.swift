//
//  LocalDataManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import Foundation

class UserDataManager: ObservableObject {
    @Published var favorites: Set<Int>
    @Published var incorrects: Set<Int>
    
    private var questionStatus: [Int:UserQuestionStatus]
    
    init() {
        self.favorites = DataStorage.getSet(key: DataStorage.favoritesKey)
        self.incorrects = DataStorage.getSet(key: DataStorage.incorrectsKey)
        self.questionStatus = DataStorage.getQuestionStatus()
    }
    
    func toggleFavorite(questionId: Int) {
        if favorites.contains(questionId) {
            favorites.remove(questionId)
        } else {
            favorites.insert(questionId)
        }
        
        DataStorage.saveSet(key: DataStorage.favoritesKey, set: favorites)
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
        
        return self.questionStatus[questionId]!.comment
    }
    
    func updateQuestionComment(questionId: Int, comment: String) {
        guard questionStatus[questionId] != nil else {
            print("Update question comment failed: question ID \(questionId) not found")
            return
        }
        
        self.questionStatus[questionId]!.comment = comment
        DataStorage.saveQuestionStatus(questionId: questionId,
                                       questionStatus: questionStatus[questionId]!)
    }
    
    func getQuestionChoices(questionId: Int) -> Set<Int>? {
        guard questionStatus[questionId] != nil else {
            print("Update question choices failed: question ID \(questionId) not found")
            return nil
        }
        
        return self.questionStatus[questionId]!.lastChoices
    }
    
    func updateQuestionChoices(questionId: Int, choices: Set<Int>, isCorrect: Bool) {
        guard questionStatus[questionId] != nil else {
            print("Update question choices failed: question ID \(questionId) not found")
            return
        }
        
        self.questionStatus[questionId]!.lastChoices = choices
        
        if !isCorrect {
            self.questionStatus[questionId]!.incorrectCount += 1
        }
        
        DataStorage.saveQuestionStatus(questionId: questionId,
                                       questionStatus: questionStatus[questionId]!)
    }
    
    func getQuestionIncorrectCount(questionId: Int) -> Int? {
        guard questionStatus[questionId] != nil else {
            print("Update question choices failed: question ID \(questionId) not found")
            return nil
        }
        
        return self.questionStatus[questionId]!.incorrectCount
    }
    
    func getIncorrectsCountList() -> [(Int, Int)] {
        questionStatus.map{ ($1.incorrectCount, $0) }.sorted{ $0.0 != $1.0 ? $0.0 > $1.0 : $0.1 < $1.1 }
    }
}
