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
    var isIncrement: Binding<Bool> = .constant(true)
    @Published var isMemoryMode = false
    var userAnswer: Binding<Set<Int>> = .constant(Set<Int>())
    
    @Published var questionIndex: Int
    
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
    
    func incrementQuestionIndex() {
        isIncrement.wrappedValue = true
        userAnswer.wrappedValue.removeAll()
        withAnimation(.easeInOut(duration: 0.5)) {
            if questionIndex < questionAmount()  {
                questionIndex = questionIndex + 1
            }
        }
    }
    
    func decrementQuestionIndex() {
        isIncrement.wrappedValue = false
        userAnswer.wrappedValue.removeAll()
        withAnimation(.easeInOut(duration: 0.5)) {
            if questionIndex > 1 {
                questionIndex = questionIndex - 1
            }
        }
    }
    
    func verifyAnswer() -> Bool {
        if let selectedQuestion = selectedQuestion {
            return selectedQuestion.checkAnswer(choices: self.userAnswer.wrappedValue)
        } else {
            return false
        }
    }
    
    func setQuestionIndex(toSetQuestionIndex: Int) {
        isIncrement.wrappedValue = toSetQuestionIndex > self.questionIndex
        withAnimation(.easeInOut(duration: 0.5)) {
            if toSetQuestionIndex <= questionAmount() && toSetQuestionIndex > 0 {
                self.questionIndex = toSetQuestionIndex
            }
        }
    }
    
    func toggleMemoryMode() {
        self.isMemoryMode.toggle()
        if !isMemoryMode {
            userAnswer.wrappedValue.removeAll()
        }
    }
    
    func bindIsIncrement(isIncrement: Binding<Bool>) {
        self.isIncrement = isIncrement
    }
    
    func bindUserAnswer(userAnswer: Binding<Set<Int>>) {
        self.userAnswer = userAnswer
    }
    
    func updateQuestionList(questionIds: Set<Int>) {
        self.questions = self.globalQuestions.filter{ questionIds.contains($0.id) }
    }
}
