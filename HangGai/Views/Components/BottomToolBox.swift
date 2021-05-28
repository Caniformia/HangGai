//
//  BottomToolBox.swift
//  HangGai
//
//  Created by TakiP on 2021/5/22.
//

import SwiftUI

struct BottomToolBox: View {
    @ObservedObject var questionManager: QuestionManager
    @State var showInfoModal: Bool
    var body: some View {
        HStack(alignment: .center){
            Button(action: {
            }, label: {
                Image(systemName: "bookmark.circle").resizable()
                    .frame(width: 24.0, height: 24.0)
            }).foregroundColor(.black)
            Button(action: {
                self.questionManager.toggleMemoryMode()
            }, label: {
                Image(systemName: self.questionManager.isMemoryMode ? "book.circle.fill" : "book.circle").resizable()
                    .frame(width: 24.0, height: 24.0)
            }).foregroundColor(.black)
            Divider().frame(height: 20)
            LargeButton(title: "", backgroundColor: Color.black, foregroundColor: Color.white) {
            }
            .padding([.top, .bottom], 10)
            Divider().frame(height: 20)
            Button(action: {
                self.showInfoModal = true
            }, label: {
                Image(systemName: "info.circle.fill").resizable()
                    .frame(width: 24.0, height: 24.0)
            }).foregroundColor(.black)
            .sheet(isPresented: self.$showInfoModal) {
                InfoModal(showInfoModal: $showInfoModal)
            }
        }.padding(.horizontal)
    }
}
