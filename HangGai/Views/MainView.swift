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
    @State var showChapterPopover = false
    @State var isInitialized = true

    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var noticeManager: NoticeManager

    var questionModule: some View {
        QuestionModule(isInitialized: $isInitialized)
                .blur(radius: isInitialized ? 0 : 20)
                .ifTrueThenModify(!isInitialized) {
                    AnyView($0.overlay(IntroductionOverlay(isInitialized: $isInitialized).padding(.vertical).opacity(isInitialized ? 0 : 1).blur(radius: isInitialized ? 50 : 0)))
                }
                .ifTrueThenModify(isInitialized) {
                    AnyView($0.onTapGesture {
                        withAnimation {
                            showChapterPopover = false
                            showSettingModal = false
                        }
                    })
                }
    }

    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                QuestionNavigationModule(showChapterPopover: $showChapterPopover).padding()
                VStack {
                    questionModule.padding(.horizontal)
                    BottomToolBox(showSettingModal: $showSettingModal, isInitialized: $isInitialized)
                }
            }.onAppear {
                questionManager.bindUserDataManager(userDataManager: userDataManager)
                self.isInitialized = userDataManager.isInitialized()
            }
        } else {
            HStack {
                VStack {
                    QuestionNavigationModule(showChapterPopover: $showChapterPopover).padding()
                    questionModule.padding([.leading, .bottom])
                }
                BottomToolBox(showSettingModal: $showSettingModal, isInitialized: $isInitialized)
            }.onAppear {
                questionManager.bindUserDataManager(userDataManager: userDataManager)
                self.isInitialized = userDataManager.isInitialized()
            }
        }
    }
}
