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
    
    @ObservedObject var questionManager: QuestionManager
    @State var showInfoModal = false
    
    @State var direction = ""
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    
    var body: some View {
        VStack() {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                QuestionNavigationModule(questionManager: questionManager)
            }.padding(.horizontal).padding(.top, 10)
            HStack(alignment: .center) {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack(alignment: .leading){
                        if let selectedQuestion = questionManager.selectedQuestion {
                            QuestionModule(question: selectedQuestion)
                            Spacer()
                        } else {
                            Spacer()
                            Text("No Question.")
                            Spacer()
                        }
                    }.padding(.horizontal).padding(.top,5)
                    Spacer()
                }.padding(.horizontal)
            }
            Spacer()
            HStack(alignment: .center){
                Button(action: {
                    self.showInfoModal = true
                    self.endEditing()
                }, label: {
                    Image(systemName: "bookmark.circle").resizable()
                        .frame(width: 24.0, height: 24.0)
                }).foregroundColor(.black)
                Button(action: {
                    self.showInfoModal = true
                    self.endEditing()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right.circle").resizable()
                        .frame(width: 24.0, height: 24.0)
                }).foregroundColor(.black)
                Divider().frame(height: 20)
                LargeButton(title: self.direction, backgroundColor: Color.black, foregroundColor: Color.white) {
                }
                Divider().frame(height: 20)
                Button(action: {
                    self.showInfoModal = true
                    self.endEditing()
                }, label: {
                    Image(systemName: "info.circle.fill").resizable()
                        .frame(width: 24.0, height: 24.0)
                }).foregroundColor(.black)
                .sheet(isPresented: self.$showInfoModal) {
                    InfoModal(showInfoModal: $showInfoModal)
                }
            }.padding(.horizontal)
        }.gesture(DragGesture()
                    .onChanged { gesture in
                        if self.isSwipping {
                            self.startPos = gesture.location
                            self.direction = "swiping..."
                            self.isSwipping.toggle()
                        }
                    }
                    .onEnded { gesture in
                        let xDist =  abs(gesture.location.x - self.startPos.x)
                        let yDist =  abs(gesture.location.y - self.startPos.y)
                        if self.startPos.x > gesture.location.x + 20 && yDist < xDist {
                            questionManager.incrementQuestionIndex()
                        }
                        else if self.startPos.x < gesture.location.x - 20 && yDist < xDist {
                            questionManager.decrementQuestionIndex()
                        }
                        self.isSwipping.toggle()
                    }
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(questionManager: QuestionManager())
        }
    }
}
