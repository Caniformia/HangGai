//
//  QuestionModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionModule: View {
    @ObservedObject var questionManager: QuestionManager
    
    var body: some View {
        if let selectedQuestion = self.questionManager.selectedQuestion {
        Group{
            Text(selectedQuestion.questionText).font(.custom("FZSSJW--GB1-0", size: 45))
            ForEach(selectedQuestion.options.indices) { optionIndex in
                AnswerButton(backgroundColor: Color.white, foregroundColor: Color.black, fontSize: 15, answerTagID: optionIndex, questionManager: questionManager)
            }
        }
        .transition(self.questionManager.getIsIncrement() ? (.moveOutAndIn) : (.moveInAndOut))
        .id(selectedQuestion.id)
        .padding(.horizontal)
        } else {
                Spacer()
                Text("No Question.")
        }
    }
    
    init(questionManager: QuestionManager) {
        self.questionManager = questionManager
    }
}

struct QuestionModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionModule(questionManager: QuestionManager())
    }
}
