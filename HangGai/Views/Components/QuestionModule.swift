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
            VStack(alignment: .leading) {
                if selectedQuestion.imgName == "" {
                    VStack(alignment: .leading) {
                        Text(selectedQuestion.questionText).font(.custom("FZSSJW--GB1-0", size: 35)).padding(.top, 10)
                            .minimumScaleFactor(0.00001)
                    }.frame(height: 200)
                }
                else {
                    VStack(alignment: .leading) {
                        Text(selectedQuestion.questionText).font(.custom("FZSSJW--GB1-0", size: 35)).padding(.top, 10)
                            .minimumScaleFactor(0.00001)
                        Image(selectedQuestion.imgName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0.8)
                    }.frame(minHeight: 200)
                }
                //Spacer()
                HStack(alignment: .bottom){
                    VStack(alignment: .center) {
                        ForEach(selectedQuestion.options.indices) { optionIndex in
                            AnswerButton(backgroundColor: Color.white, foregroundColor: Color.black, fontSize: 15, answerTagID: optionIndex, questionManager: questionManager)
                                .padding([.top, .bottom], 5)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        }
                    }
                }.frame(minHeight: 200, idealHeight:250)
                .padding(.top, 10)
            }
            .transition(self.questionManager.getIsIncrement() ? (.moveOutAndIn) : (.moveInAndOut))
            .id(selectedQuestion.id)
            .padding(.horizontal)
        } else {
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
