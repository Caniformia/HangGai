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
        VStack {
            HStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        self.userDataManager.toggleFavorite(questionId: questionManager.selectedQuestion?.id ?? 0)
                    }
                }, label: {
                    Image(systemName: self.userDataManager.favorites.contains(questionManager.selectedQuestion?.id ?? 0) ? "bookmark.circle.fill" : "bookmark.circle").resizable()
                        .frame(width: 24.0, height: 24.0)
                }).foregroundColor(.black)
                Button(action: {
                    self.questionManager.toggleMemoryMode()
                }, label: {
                    Image(systemName: (self.questionManager.getIsMemoryMode() && !self.questionManager.isDisplayingAnswer) ? "book.circle.fill" : "book.circle").resizable()
                        .frame(width: 24.0, height: 24.0)
                }).foregroundColor(.black)
                Divider().frame(height: 20)
                /*
                MarqueeText(
                    text: self.noticeManager.selectedNotice.toString(),
                    font: UIFont(name: "FZSSJW--GB1-0", size: 15) ?? UIFont.preferredFont(forTextStyle: .subheadline),
                    leftFade: 4,
                    rightFade: 24,
                    startDelay: 2
                )
                .id("\(noticeManager.noticeIndex)")
                .transition(.expandVertically)
 */
 
                 LargeButton(title: "", backgroundColor: Color.black, foregroundColor: Color.white) {
                    withAnimation {
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
                 }
                //.padding([.top, .bottom], 10)
                Divider().frame(height: 20)
                Button(action: {
                    withAnimation {
                        self.showSettingModal.toggle()
                    }
                }, label: {
                    Image(systemName: showSettingModal ?  "line.horizontal.3.circle.fill" : "line.horizontal.3.circle").resizable()
                        .frame(width: 24.0, height: 24.0)
                })
                .foregroundColor(.black)
            }
            .padding(.horizontal)
            QuestionListTab(showQuestionListTab: $showSettingModal)
                .frame(maxHeight: showSettingModal ? nil : 0)
                .padding(.horizontal)
        }
    }
}
