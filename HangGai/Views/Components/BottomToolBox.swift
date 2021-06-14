//
//  BottomToolBox.swift
//  HangGai
//
//  Created by TakiP on 2021/5/22.
//

import SwiftUI

struct BottomToolBox: View {
    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var noticeManager: NoticeManager

    @Binding var showSettingModal: Bool
    @Binding var isInitialized: Bool

    @Environment(\.colorScheme) var colorScheme

    let smallConfiguration = UIImage.SymbolConfiguration(scale: .small)

    init(isInitialized: Binding<Bool>, showSettingModal: Binding<Bool>) {
        self._isInitialized = isInitialized
        self._showSettingModal = showSettingModal
    }

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        userDataManager.toggleFavorite(questionId: questionManager.selectedQuestion?.id ?? 0)
                    }
                }, label: {
                    Image(systemName: userDataManager.favorites.contains(questionManager.selectedQuestion?.id ?? 0) ? "bookmark.circle.fill" : "bookmark.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(size: 24, weight: .thin))
                }).foregroundColor(colorScheme == .dark ? .white : .black)
                Button(action: {
                    if !questionManager.isDisplayingAnswer && !questionManager.isQuestionAnswered(questionId: questionManager.selectedQuestion?.id ?? 0) {
                        questionManager.toggleMemoryMode()
                    }
                }, label: {
                    Image(systemName: (questionManager.getIsMemoryMode() && !questionManager.isDisplayingAnswer) ? "book.circle.fill" : "book.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(size: 24, weight: .thin))
                }).foregroundColor(colorScheme == .dark ? .white : .black)
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
                LargeButton(title: "", backgroundColor: colorScheme == .light ? .white : .black, foregroundColor: colorScheme == .dark ? .white : .black) {
                    if isInitialized {
                        if questionManager.getIsMemoryMode() {
                            questionManager.incrementQuestionIndex()
                            if questionManager.isDisplayingAnswer {
                                questionManager.toggleMemoryMode()
                                questionManager.isDisplayingAnswer.toggle()
                            }
                        } else {
                            questionManager.verifyAnswer(withSwitchQuestion: false)
                        }
                    }
                }
                Divider().frame(height: 20)
                Button(action: {
                    withAnimation {
                        self.showSettingModal.toggle()
                    }
                }, label: {
                    Image(systemName: showSettingModal ? "line.horizontal.3.circle.fill" : "line.horizontal.3.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(size: 24, weight: .thin))
                })
                        .foregroundColor(colorScheme == .dark ? .white : .black)
            }
                    .padding(.horizontal)
            QuestionListTab(showQuestionListTab: $showSettingModal)
                    .frame(maxHeight: showSettingModal ? nil : 0)
                    .padding(.horizontal)
        }
    }
}

struct BottomToolBox_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolBox(isInitialized: .constant(true), showSettingModal: .constant(true))
    }
}
