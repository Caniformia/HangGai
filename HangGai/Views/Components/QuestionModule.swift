//
//  QuestionModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import Foundation
import SwiftUI

struct QuestionModule: View {
    @EnvironmentObject var questionManager: QuestionManager
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    
    @Binding var isInitialized: Bool
    
    init(isInitialized: Binding<Bool>) {
        self._isInitialized = isInitialized
    }
    
    var body: some View {
        if let selectedQuestion = self.questionManager.selectedQuestion {
            ZStack {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        if selectedQuestion.imgName == "" {
                            VStack(alignment: .leading) {
                                Text(selectedQuestion.questionText).font(.custom("FZSSJW--GB1-0", size: 35)).padding(.top, 10)
                                    .minimumScaleFactor(0.00001)
                            }.frame(height: 200, alignment: .top)
                        }
                        else {
                            VStack(alignment: .leading) {
                                Text(selectedQuestion.questionText).font(.custom("FZSSJW--GB1-0", size: 35)).padding(.top, 10)
                                    .minimumScaleFactor(0.00001)
                                Image(selectedQuestion.imgName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0.8)
                            }.frame(minHeight: 200, alignment: .top)
                        }
                        //Spacer()
                        HStack(alignment: .bottom) {
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
                    .padding(.horizontal)
                    .transition(questionManager.isIncrement ? (.moveOutAndIn) : (.moveInAndOut))
                    .id("\(selectedQuestion.id).\(questionManager.questionAmount())")
                }
                .blur(radius: questionManager.playAnswerVerifyAnimation ? 1.0 : 0.0)
                .opacity(questionManager.playAnswerVerifyAnimation ? 0.05 : 1.0)
                
                if questionManager.playAnswerVerifyAnimation {
                    BigCorrectMark(correct: questionManager.isAnswerRight).transition(.opacity)
                }
            }
            .gesture(DragGesture()
                        .onChanged { gesture in
                            if self.isSwipping {
                                self.startPos = gesture.location
                                self.isSwipping.toggle()
                            }
                        }
                        .onEnded { gesture in
                            let xDist =  abs(gesture.location.x - self.startPos.x)
                            let yDist =  abs(gesture.location.y - self.startPos.y)
                            if isInitialized {
                                if self.startPos.x > gesture.location.x + 20 && yDist < xDist {
                                    if questionManager.getIsMemoryMode() {
                                        questionManager.incrementQuestionIndex()
                                        if questionManager.isDisplayingAnswer {
                                            questionManager.toggleMemoryMode()
                                            questionManager.isDisplayingAnswer.toggle()
                                        }
                                    } else {
                                        questionManager.swipedScreenRight()
                                    }
                                }
                                else if self.startPos.x < gesture.location.x - 20 && yDist < xDist {
                                    questionManager.decrementQuestionIndex()
                                }
                            }
                            self.isSwipping.toggle()
                        }
            )
            .animation(Animation.easeInOut(duration: AnimationSettingManager().getVerifyAnswerDuration()).delay(AnimationSettingManager().getVerifyAnswerDelay()), value: questionManager.playAnswerVerifyAnimation)
        } else {
            Text("No Question.")
            
        }
    }
}

struct QuestionModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionModule(isInitialized: .constant(true))
    }
}
