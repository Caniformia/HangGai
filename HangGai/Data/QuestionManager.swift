//
//  QuestionManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import Foundation
import SwiftUI

class QuestionManager: ObservableObject {
    private var questions: [Question]
    var isIncrement: Binding<Bool> = .constant(true)
    var isMemoryMode: Binding<Bool> = .constant(true)
    
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
            self.questions = questions
            self.questionIndex = 1
        } else {
            self.questions = []
            self.questionIndex = 0
        }
    }
    
    func questionAmount () -> Int{
        return questions.count;
    }
    
    func incrementQuestionIndex() {
        isIncrement.wrappedValue = true
        withAnimation(.easeInOut(duration: 0.5)) {
            if questionIndex < questionAmount()  {
                questionIndex = questionIndex + 1
            }
        }
    }
    
    func decrementQuestionIndex() {
        isIncrement.wrappedValue = false
        withAnimation(.easeInOut(duration: 0.5)) {
            if questionIndex > 1 {
                questionIndex = questionIndex - 1
            }
        }
    }
    
    func verifyAnswer() {
        
    }
    
    func bindIsIncrement(isIncrement: Binding<Bool>) {
        self.isIncrement = isIncrement
    }
    
    func bindIsMemoryMode(isMemoryMode: Binding<Bool>) {
        self.isMemoryMode = isMemoryMode
    }
}
