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
    private var questions: [Question] // current questions

    @Published var isMemoryMode = false
    @Published var userAnswer: Set<Int> = []
    
    @Published var questionIndex: Int {
        willSet {
            self.userAnswer.removeAll()
        }
    }
    
    @Published var isIncrement: Bool

    var selectedQuestion: Question? {
        if (questionIndex <= 0) {
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
        print("\(self.isIncrement)")
        return self.isIncrement
    }
    
    func getUserAnswer() -> Set<Int> {
        return self.userAnswer
    }
    
    func incrementQuestionIndex() {
        isIncrement = true
        withAnimation(.easeInOut(duration: 0.5)) {
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
    
    func verifyAnswer() -> Bool {
        if let selectedQuestion = selectedQuestion {
            return selectedQuestion.checkAnswer(choices: self.userAnswer)
        } else {
            return false
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
        print("toggled memory mode, now is \(userAnswer).")
    }
    
    func toggleUserAnswer(answerTagID: Int) {
        if self.userAnswer.contains(answerTagID) {
            self.userAnswer.remove(answerTagID)
        } else {
            self.userAnswer.insert(answerTagID)
        }
    }
    
    func updateQuestionList(questionIds: Set<Int>) {
        self.questions = self.globalQuestions.filter{ questionIds.contains($0.id) }
    }
}
