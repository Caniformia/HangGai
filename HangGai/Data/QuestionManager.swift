//
//  QuestionManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import Foundation

class QuestionManager: ObservableObject {
    private var questions: [Question]
    
    @Published var questionIndex:Int
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
        if questionIndex < questionAmount()  {
            questionIndex = questionIndex + 1
        }
    }
    
    func decrementQuestionIndex() {
        if questionIndex > 1 {
            questionIndex = questionIndex - 1
        }
    }
    
    func verifyAnswer() {
        
    }
}
