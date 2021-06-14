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
            userAnswer.removeAll()
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
        if let questions = QuestionLoader.loadQuestions() {
            globalQuestions = questions
            self.questions = questions
            questionIndex = 1
        } else {
            globalQuestions = []
            questions = []
            questionIndex = 0
        }
        isIncrement = true
    }
    
    func questionAmount() -> Int {
        questions.count;
    }
    
    func questionChapter() -> Int {
        withAnimation(.easeInOut(duration: 0.5)) {
            if let selectedQuestion = selectedQuestion {
                return selectedQuestion.chapter
            } else {
                return 0;
            }
        }
    }
    
    func getSelectedQuestion() -> Question? {
        selectedQuestion
    }
    
    func getIsMemoryMode() -> Bool {
        isMemoryMode
    }
    
    func getIsIncrement() -> Bool {
        isIncrement
    }
    
    func getUserAnswer() -> Set<Int> {
        userAnswer
    }
    
    func incrementQuestionIndex() {
        isIncrement = true
        withAnimation(.easeInOut(duration: isMemoryMode ? 0.5 : 2 * (AnimationSettingManager().getVerifyAnswerDelay() + AnimationSettingManager().getVerifyAnswerDuration()))) {
            if questionIndex < questionAmount() {
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
        if userAnswer.isEmpty {
            incrementQuestionIndex()
        } else {
            verifyAnswer(withSwitchQuestion: true)
        }
    }
    
    func verifyAnswer(withSwitchQuestion: Bool) {
        if let selectedQuestion = selectedQuestion {
            if answeredQuestions.contains(selectedQuestion.id) {
                withAnimation {
                    incrementQuestionIndex()
                }
                return
            }
            isAnswerRight = selectedQuestion.checkAnswer(choices: userAnswer)
            withAnimation {
                answeredQuestions.insert(selectedQuestion.id)
                userDataManager.updateQuestionChoices(questionId: selectedQuestion.id, choices: userAnswer, isCorrect: isAnswerRight)
                userDataManager.updateIncorrects(questionId: selectedQuestion.id, isCorrect: selectedQuestion.checkAnswer(choices: self.userAnswer))
            }
            if withSwitchQuestion {
                if selectedQuestion.checkAnswer(choices: userAnswer) {
                    incrementQuestionIndex()
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
        isIncrement = toSetQuestionIndex > questionIndex
        withAnimation(.easeInOut(duration: 0.5)) {
            if toSetQuestionIndex <= questionAmount() && toSetQuestionIndex > 0 {
                self.questionIndex = toSetQuestionIndex
            }
        }
    }
    
    func toggleMemoryMode() {
        isMemoryMode.toggle()
    }
    
    func toggleUserAnswer(answerTagID: Int) {
        if userAnswer.contains(answerTagID) {
            userAnswer.remove(answerTagID)
        } else {
            userAnswer.insert(answerTagID)
        }
    }
    
    func updateQuestionList(questionIds: Set<Int>, identifier: String) {
        if identifier != questionSetIdentifier {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.questions = self.globalQuestions.filter {
                    questionIds.contains($0.id)
                }
                self.questionSetIdentifier = identifier
                self.questionIndex = 1
                self.isMemoryMode = false
                self.isDisplayingAnswer = false
            }
        }
    }
    
    func updateQuestionList(identifier: String) {
        if identifier != questionSetIdentifier {
            withAnimation(.easeInOut(duration: 0.5)) {
                let questionIds: Set<Int> = (identifier == "Favorites") ? userDataManager.getFavorites()
                    : ((identifier == "Incorrects") ? userDataManager.getIncorrects()
                        : Set(globalQuestions.map {
                            $0.id
                        }))
                self.questions = (identifier == "Random") ? (self.globalQuestions.filter {
                    questionIds.contains($0.id)
                }.shuffled()) : (self.globalQuestions.filter {
                    questionIds.contains($0.id)
                })
                self.questionSetIdentifier = identifier
                self.questionIndex = (identifier == "Meta") ? userDataManager.getLastVisitedQuestionId() : 1
                self.isMemoryMode = false
                self.isDisplayingAnswer = false
            }
        }
    }
    
    func getQuestionListCount(identifier: String) -> Int {
        (identifier == "Favorites") ?
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
        questionIndex = (userDataManager.getLastVisitedQuestionId() == 0) ? 1 : userDataManager.getLastVisitedQuestionId()
    }
    
    func getChapterQuestions(chapterId: Int) -> Set<Int> {
        Set(questions.filter {
            $0.chapter == chapterId
        }.map {
            $0.id
        })
    }
    
    func getIndexByQuestionId(questionId: Int) -> Int {
        if questionId == 0 {
            return (questions.firstIndex(where: { (e) -> Bool in
                return e.id == selectedQuestion?.id
            }) ?? 0) + 1
        }
        return ((questions.firstIndex(where: { (e) -> Bool in
            return e.id == questionId
        }) ?? 0) + 1 )
    }
    
    func isQuestionAnswered(questionId: Int) -> Bool {
        answeredQuestions.contains(questionId)
    }
}
