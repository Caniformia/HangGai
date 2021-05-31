//
//  BottomToolBox.swift
//  HangGai
//
//  Created by TakiP on 2021/5/22.
//

import SwiftUI
import MarqueeText

struct BottomToolBox: View {
    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var noticeManager: NoticeManager
    
    @State var showSettingModal: Bool
    var body: some View {
        HStack(alignment: .center){
            Button(action: {
                self.userDataManager.toggleFavorite(questionId: questionManager.questionIndex)
            }, label: {
                Image(systemName: self.userDataManager.favorites.contains(questionManager.questionIndex) ? "bookmark.circle.fill" : "bookmark.circle").resizable()
                    .frame(width: 24.0, height: 24.0)
            }).foregroundColor(.black)
            Button(action: {
                self.questionManager.toggleMemoryMode()
            }, label: {
                Image(systemName: (self.questionManager.getIsMemoryMode() && !self.questionManager.isDisplayingAnswer) ? "book.circle.fill" : "book.circle").resizable()
                    .frame(width: 24.0, height: 24.0)
            }).foregroundColor(.black)
            Divider().frame(height: 20)
            MarqueeText(
                text: self.noticeManager.selectedNotice.toString(),
                font: UIFont(name: "FZSSJW--GB1-0", size: 15) ?? UIFont.preferredFont(forTextStyle: .subheadline),
                leftFade: 4,
                rightFade: 24,
                startDelay: 2
            )
            .id("\(noticeManager.noticeIndex)")
            .transition(.expandVertically)
            /*
            LargeButton(title: "", backgroundColor: Color.black, foregroundColor: Color.white) {
                questionManager.updateQuestionList(questionIds: userDataManager.getIncorrects())
            }
 */
            .padding([.top, .bottom], 10)
            Divider().frame(height: 20)
            Button(action: {
                self.showSettingModal = true
            }, label: {
                Image(systemName: "line.horizontal.3.circle.fill").resizable()
                    .frame(width: 24.0, height: 24.0)
            }).foregroundColor(.black)
            .sheet(isPresented: self.$showSettingModal) {
                SettingModal(showSettingModal: $showSettingModal)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
}
