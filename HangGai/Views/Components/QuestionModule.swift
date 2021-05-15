//
//  QuestionModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionModule: View {
    private var question: Question
    
    var body: some View {
        Text(question.questionText).font(.custom("FZSSJW--GB1-0", size: 45))
        ForEach(question.options.indices) { optionIndex in
            AnswerButton(title: question.options[optionIndex], backgroundColor: Color.white, foregroundColor: Color.black,fontSize: 15, answerTagID: optionIndex) {
            }
        }
    }
    
    init(question: Question) {
        self.question = question
    }
}

struct QuestionModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionModule(question: QuestionLoader.loadQuestions()![0])
    }
}
