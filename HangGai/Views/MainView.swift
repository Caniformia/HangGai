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

    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var noticeManager: NoticeManager

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                QuestionNavigationModule(showChapterPopover: $showChapterPopover)
            }.padding(.horizontal).padding(.top, 10)
            HStack(alignment: .center) {
                //ScrollView (.vertical, showsIndicators: false) {
                ZStack {
                    QuestionModule(isInitialized: $isInitialized)
                            .padding(.top, 20)
                            //}
                            //.scrollOnlyOnOverflow()
                            .padding(.horizontal)
                            .blur(radius: isInitialized ? 0.0 : 20.0)
                            .ifTrueThenModify(!isInitialized) {
                                AnyView($0.overlay(IntroductionOverlay(isInitialized: $isInitialized).padding(.vertical).opacity(isInitialized ? 0 : 1.0).blur(radius: isInitialized ? 50.0 : 0)))
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

            }
            Spacer()
            BottomToolBox(isInitialized: $isInitialized, showSettingModal: $showSettingModal)
        }
                .onAppear {
                    questionManager.bindUserDataManager(userDataManager: userDataManager)
                    self.isInitialized = userDataManager.isInitialized()
                }
    }
}
