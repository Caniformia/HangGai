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
    
    @State var showSettingModal = false
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    
    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var noticeManager: NoticeManager
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                QuestionNavigationModule()
            }.padding(.horizontal).padding(.top, 10)
            HStack(alignment: .center) {
                //ScrollView (.vertical, showsIndicators: false) {
                        QuestionModule()
                        .padding(.top,20)
                //}
                //.scrollOnlyOnOverflow()
                .padding(.horizontal)
                
            }
            Spacer()
            BottomToolBox(showSettingModal: showSettingModal)
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
                                if questionManager.isDisplayingAnswer {
                                    questionManager.toggleMemoryMode()
                                    questionManager.isDisplayingAnswer.toggle()
                                }
                            } else {
                                questionManager.verifyAnswer()
                            }
                        }
                        else if self.startPos.x < gesture.location.x - 20 && yDist < xDist {
                            questionManager.decrementQuestionIndex()
                        }
                        self.isSwipping.toggle()
                    }
        ).onAppear() {
            questionManager.bindUserDataManager(userDataManager: userDataManager)
        }
    }
}
