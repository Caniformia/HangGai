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

    @State var selectedQuestionList: String = ""
    @Binding var showSettingModal: Bool
    @Binding var isInitialized: Bool

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(showSettingModal: Binding<Bool>, isInitialized: Binding<Bool>) {
        self._showSettingModal = showSettingModal
        self._isInitialized = isInitialized
    }

    var favoriteButton: some View {
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
    }

    var answerButton: some View {
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
    }

    var commitButton: some View {
        LargeButton(title: "", backgroundColor: colorScheme == .light ? .black : .black, foregroundColor: colorScheme == .dark ? .white : .black) {
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
    }

    var switchButton: some View {
        Button(action: {
            withAnimation {
                self.showSettingModal.toggle()
            }
        }, label: {
            Image(systemName: showSettingModal ? "line.horizontal.3.circle.fill" : "line.horizontal.3.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .font(.system(size: 24, weight: .thin))
        }).foregroundColor(colorScheme == .dark ? .white : .black)
    }

    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                HStack(alignment: .center) {
                    favoriteButton
                    answerButton
                    Divider().frame(height: 20)
                    commitButton.frame(height: 25)
                    Divider().frame(height: 20)
                    switchButton
                }.padding()
                if (showSettingModal) {
                    QuestionListTab(selectedQuestionList: $selectedQuestionList, showQuestionListTab: $showSettingModal)
                            .padding(.horizontal)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }.onAppear(){
                selectedQuestionList = questionManager.getQuestionSetIdentifier()
            }
        } else {
            HStack {
                VStack(alignment: .center) {
                    switchButton
                    Divider().frame(width: 20)
                    commitButton.frame(width: 25)
                    Divider().frame(width: 20)
                    favoriteButton
                    answerButton
                }.padding([.vertical, .trailing])
                if (showSettingModal) {
                    QuestionListTab(selectedQuestionList: $selectedQuestionList, showQuestionListTab: $showSettingModal)
                            .padding(.vertical)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }.onAppear(){
                selectedQuestionList = questionManager.getQuestionSetIdentifier()
            }
        }
    }
}

struct BottomToolBox_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolBox(showSettingModal: .constant(true), isInitialized: .constant(true))
                .environmentObject(UserDataManager())
                .environmentObject(QuestionManager())
                .environmentObject(NoticeManager())
    }
}
