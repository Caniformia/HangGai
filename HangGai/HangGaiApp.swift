//
//  HangGaiApp.swift
//  HangGai
//
//  Created by TakiP on 2021/5/13.
//

import SwiftUI

@main
struct HangGaiApp: App {    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(UserDataManager())
                .environmentObject(QuestionManager())
                .environmentObject(NoticeManager())
        }
    }
}
