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
    var body: some View {
        VStack() {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Text("1/951").font(.custom("FZSSJW--GB1-0", size: 15)).kerning(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                Spacer()
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
            }.padding(.horizontal).padding(.top, 10)
            HStack(alignment: .center) {
                ScrollView (.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    Text("下列关于航天飞机的说法正确的是？").font(.custom("FZSSJW--GB1-0", size: 50))
                    AnswerButton(title: "可以重复使用，是目前最安全，最有效的航天器。", backgroundColor: Color.white, foregroundColor: Color.black,fontSize: 15, answerTagID: 0) {
                    }
                    AnswerButton(title: "可以进入近地轨道完成多种任务。", backgroundColor: Color.white, foregroundColor: Color.black,fontSize: 15, answerTagID: 1) {
                    }
                    AnswerButton(title: "能完成包括人造地球卫星、飞船、空间探测器甚至小型空间站的许多功能。", backgroundColor: Color.white, foregroundColor: Color.black,fontSize: 15, answerTagID: 2) {
                    }
                    AnswerButton(title: "目前世界上只有美国和前苏联有过航天飞机。", backgroundColor: Color.white, foregroundColor: Color.black,fontSize: 15, answerTagID: 3) {
                    }
                    Spacer()
                }.padding()
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
                }).foregroundColor(.black).padding(.vertical)
                Button(action: {
                    self.showInfoModal = true
                    self.endEditing()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.right.circle").resizable()
                        .frame(width: 24.0, height: 24.0)
                }).foregroundColor(.black).padding(.vertical)
                Divider().frame(height: 20).padding(.vertical)
                LargeButton(title: "题目列表", backgroundColor: Color.black, foregroundColor: Color.white) {
                }
            }.padding(.horizontal)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
            MainView()
        }
    }
}
