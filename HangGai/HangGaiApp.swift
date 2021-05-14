//
//  HangGaiApp.swift
//  HangGai
//
//  Created by TakiP on 2021/5/13.
//

import SwiftUI

@main
struct HangGaiApp: App {
    let questions = QuestionLoader.loadQuestions()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
