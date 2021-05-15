//
//  QuestionNavigationModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionNavigationModule: View {
    @ObservedObject var questionManager: QuestionManager
    
    private var nowQuestionIndex: String {
        return "\(questionManager.questionIndex)" + "/" + "\(questionManager.questionAmount())"
    }
    var body: some View {
        HStack {
            Button(action: {
                questionManager.decrementQuestionIndex()
            }, label: {
                Image(systemName: "chevron.compact.left").resizable()
                    .scaledToFit()
                    .frame(maxHeight:16)
            }).foregroundColor(.black)
            Spacer()
            Text("\(questionManager.questionIndex)").font(.custom("FZSSJW--GB1-0", size: 15)).kerning(15.0)
            BoldText(text: "/" + "\(questionManager.questionAmount())", width: 1, color: Color.black, size: 15.0, kerning: 15.0)
            Spacer()
            Button(action: {
                questionManager.incrementQuestionIndex()
            }, label: {
                Image(systemName: "chevron.compact.right").resizable()
                    .scaledToFit()
                    .frame(maxHeight:16)
            }).foregroundColor(.black)
            
        }
    }
}

struct QuestionNavigationModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionNavigationModule(questionManager: QuestionManager())
    }
}
