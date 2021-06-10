//
//  QuestionManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import Foundation
import SwiftUI

class QuestionManager: ObservableObject {
    private let globalQuestions: [Question] // All questions
    private var questions: [Question] {
        willSet {
            answeredQuestions.removeAll()
        }
    }
    private var questionSetIdentifier: String = "Meta"
    @ObservedObject var userDataManager: UserDataManager = UserDataManager()
    
    @Published var isMemoryMode = false
    @Published var userAnswer: Set<Int> = []
    @Published var playAnswerVerifyAnimation: Bool = false
    @Published var isAnswerRight: Bool = false
    @Published var isDisplayingAnswer = false
    
    @Published var answeredQuestions: Set<Int> = []
    
    @Published var questionIndex: Int {
        willSet {
            self.userAnswer.removeAll()
            if questionSetIdentifier == "Meta" {
                userDataManager.updateLastVisitedQuestionId(questionId: newValue)
            }
            if isDisplayingAnswer && isMemoryMode {
                isDisplayingAnswer = false
                isMemoryMode = false
            }
        }
    }
    
    @Published var isIncrement: Bool
    
    var selectedQuestion: Question? {
        if (questionIndex <= 0 || questionIndex > questionAmount()) {
            return nil
        } else {
            return questions[questionIndex - 1]
        }
    }
    
    init() {
        if let questions = QuestionLoader.loadQuestions(){
            self.globalQuestions = questions
            self.questions = questions
            self.questionIndex = 1
        } else {
            self.globalQuestions = []
            self.questions = []
            self.questionIndex = 0
        }
        self.isIncrement = true
    }
    
    func questionAmount () -> Int {
        return questions.count;
    }
    
    func questionChapter () -> Int {
        withAnimation(.easeInOut(duration: 0.5)){
            if let selectedQuestion = self.selectedQuestion {
                return selectedQuestion.chapter
            } else {
                return 0;
            }
        }
    }
    
    func getSelectedQuestion() -> Question? {
        return self.selectedQuestion
    }
    
    func getIsMemoryMode() -> Bool {
        return self.isMemoryMode
    }
    
    func getIsIncrement() -> Bool {
        return self.isIncrement
    }
    
    func getUserAnswer() -> Set<Int> {
        return self.userAnswer
    }
    
    func incrementQuestionIndex() {
        isIncrement = true
        withAnimation(.easeInOut(duration: self.isMemoryMode ? 0.5 : 2 * (AnimationSettingManager().getVerifyAnswerDelay() + AnimationSettingManager().getVerifyAnswerDuration()))) {
            if questionIndex < questionAmount()  {
                questionIndex = questionIndex + 1
            }
        }
    }
    
    func decrementQuestionIndex() {
        isIncrement = false
        withAnimation(.easeInOut(duration: 0.5)) {
            if questionIndex > 1 {
                questionIndex = questionIndex - 1
            }
        }
    }
    
    func swipedScreenRight() {
        if self.userAnswer.isEmpty {
            self.incrementQuestionIndex()
        } else {
            self.verifyAnswer(withSwitchQuestion: true)
        }
    }
    
    func verifyAnswer(withSwitchQuestion: Bool) {
        if let selectedQuestion = selectedQuestion {
            if answeredQuestions.contains(selectedQuestion.id) {
                withAnimation {
                    self.incrementQuestionIndex()
                }
                return
            }
            self.isAnswerRight = selectedQuestion.checkAnswer(choices: self.userAnswer)
            withAnimation {
                answeredQuestions.insert(selectedQuestion.id)
                userDataManager.updateQuestionChoices(questionId: selectedQuestion.id, choices: userAnswer, isCorrect: isAnswerRight)
                userDataManager.updateIncorrects(questionId: selectedQuestion.id, isCorrect: selectedQuestion.checkAnswer(choices: self.userAnswer))
            }
            if withSwitchQuestion {
                if selectedQuestion.checkAnswer(choices: self.userAnswer) {
                    self.incrementQuestionIndex()
                }
            }
            print("\(isAnswerRight)")
            withAnimation {
                self.playAnswerVerifyAnimation.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + AnimationSettingManager().getVerifyAnswerDelay() + AnimationSettingManager().getVerifyAnswerDuration()) {
                    withAnimation {
                        self.playAnswerVerifyAnimation.toggle()
                        if !withSwitchQuestion || !self.isAnswerRight { // Display answer when only verifying userAnswers or userAnswer incorrect.
                            self.isMemoryMode.toggle()
                            self.isDisplayingAnswer.toggle()
                        }
                    }
                }
            }
        }
    }
    
    func setQuestionIndex(toSetQuestionIndex: Int) {
        isIncrement = toSetQuestionIndex > self.questionIndex
        withAnimation(.easeInOut(duration: 0.5)) {
            if toSetQuestionIndex <= questionAmount() && toSetQuestionIndex > 0 {
                self.questionIndex = toSetQuestionIndex
            }
        }
    }
    
    func toggleMemoryMode() {
        self.isMemoryMode.toggle()
    }
    
    func toggleUserAnswer(answerTagID: Int) {
        if self.userAnswer.contains(answerTagID) {
            self.userAnswer.remove(answerTagID)
        } else {
            self.userAnswer.insert(answerTagID)
        }
    }
    
    func updateQuestionList(questionIds: Set<Int>, identifier: String) {
        if identifier != self.questionSetIdentifier {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.questions = self.globalQuestions.filter{ questionIds.contains($0.id) }
                self.questionSetIdentifier = identifier
                self.questionIndex = 1
                self.isMemoryMode = false
                self.isDisplayingAnswer = false
            }
        }
    }
    
    func updateQuestionList(identifier: String) {
        if identifier != self.questionSetIdentifier {
            withAnimation(.easeInOut(duration: 0.5)) {
                let questionIds: Set<Int> = (identifier == "Favorites") ? userDataManager.getFavorites()
                    : ((identifier == "Incorrects") ? userDataManager.getIncorrects()
                        : Set(globalQuestions.map{$0.id}))
                self.questions = (identifier == "Random") ? (self.globalQuestions.filter{ questionIds.contains($0.id) }.shuffled()) : (self.globalQuestions.filter{ questionIds.contains($0.id) })
                self.questionSetIdentifier = identifier
                self.questionIndex = (identifier == "Meta") ? userDataManager.getLastVisitedQuestionId() : 1
                self.isMemoryMode = false
                self.isDisplayingAnswer = false
            }
        }
    }
    
    func getQuestionListCount(identifier: String) -> Int {
        return (identifier == "Favorites") ?
            userDataManager.favorites.count : ((identifier == "Incorrects") ?
                                                userDataManager.incorrects.count : globalQuestions.count)
    }
    
    /*
    func restoreQuestionList() {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.questions = self.globalQuestions
            self.questionSetIdentifier = "Meta"
            self.questionIndex = (userDataManager.getLastVisitedQuestionId() == 0) ? 1 : userDataManager.getLastVisitedQuestionId()
            self.isMemoryMode = false
            self.isDisplayingAnswer = false
        }
    }
    */
    
    func bindUserDataManager(userDataManager: UserDataManager) {
        self.userDataManager = userDataManager
        self.questionIndex = (userDataManager.getLastVisitedQuestionId() == 0) ? 1 : userDataManager.getLastVisitedQuestionId()
    }
    
    func getChapterQuestions(chapterId: Int) -> Set<Int> {
        return Set(globalQuestions.filter{ $0.chapter == chapterId }.map { $0.id })
    }
    
    func isQuestionAnswered(questionId: Int) -> Bool {
        return answeredQuestions.contains(questionId)
    }
}
