//
//  QuestionModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionModule: View {
    private var question: Question
    private var isIncrement: Bool
    private var isMemoryMode: Bool
    
    var body: some View {
        Group{
            Text(question.questionText).font(.custom("FZSSJW--GB1-0", size: 45))
            ForEach(question.options.indices) { optionIndex in
                AnswerButton(title: question.options[optionIndex], disabled: isMemoryMode, backgroundColor: Color.white, foregroundColor: Color.black, fontSize: 15, answerTagID: optionIndex, isAnswer: question.answer.contains(optionIndex))
                    .onAppear(){
                    }
            }
        }
        .transition(isIncrement ? (.moveOutAndIn) : (.moveInAndOut))
        .id(question.id)
        .padding(.horizontal)
    }
    
    init(question: Question, isIncrement: Bool, isMemoryMode: Bool) {
        self.question = question
        self.isIncrement = isIncrement
        self.isMemoryMode = isMemoryMode
    }
}

struct QuestionModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionModule(question: QuestionLoader.loadQuestions()![0], isIncrement: true, isMemoryMode: true)
    }
}
