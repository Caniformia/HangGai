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
    
    @ObservedObject var questionManager: QuestionManager = QuestionManager()
    
    var body: some View {
        VStack() {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                QuestionNavigationModule(questionManager: questionManager)
            }.padding(.horizontal).padding(.top, 10)
            HStack(alignment: .center) {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack(alignment: .leading){
                        QuestionModule(questionManager: questionManager)
                        Spacer()
                    }.padding(.top,5)
                    Spacer()
                }.padding(.horizontal)
            }
            Spacer()
            BottomToolBox(questionManager: questionManager, showInfoModal: showInfoModal)
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
                            if questionManager.verifyAnswer() || questionManager.getIsMemoryMode() {
                                questionManager.incrementQuestionIndex()
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
