//
//  ContentView.swift
//  HangGai
//
//  Created by TakiP on 2021/5/13.
//

import SwiftUI

struct MainView: View {
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    @State var showInfoModal = false
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    
    @ObservedObject var userDataManager: UserDataManager = UserDataManager()
    @ObservedObject var questionManager: QuestionManager = QuestionManager()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                QuestionNavigationModule(questionManager: questionManager)
            }.padding(.horizontal).padding(.top, 10)
            HStack(alignment: .center) {
                //ScrollView (.vertical, showsIndicators: false) {
                        QuestionModule(questionManager: questionManager)
                        .padding(.top,20)
                //}
                //.scrollOnlyOnOverflow()
                .padding(.horizontal)
                
            }
            Spacer()
            BottomToolBox(userDataManager: userDataManager, questionManager: questionManager, showInfoModal: showInfoModal)
        }.gesture(DragGesture()
                    .onChanged { gesture in
                        if self.isSwipping {
                            self.startPos = gesture.location
                            self.isSwipping.toggle()
                        }
                    }
                    .onEnded { gesture in
                        let xDist =  abs(gesture.location.x - self.startPos.x)
                        let yDist =  abs(gesture.location.y - self.startPos.y)
                        if self.startPos.x > gesture.location.x + 20 && yDist < xDist {
                            if questionManager.getIsMemoryMode() {
                                questionManager.incrementQuestionIndex()
                            } else {
                                questionManager.verifyAnswer()
                            }
                        }
                        else if self.startPos.x < gesture.location.x - 20 && yDist < xDist {
                            questionManager.decrementQuestionIndex()
                        }
                        self.isSwipping.toggle()
                    }
        )
    }
}
