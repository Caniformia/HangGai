//
//  QuestionListTab.swift
//  HangGai
//
//  Created by TakiP on 2021/5/31.
//

import SwiftUI

struct QuestionListTab: View {
    private var questionListName: String = "顺序刷题"
    var body: some View {
        Button(action: {
        }, label: {
            VStack(alignment: .center, spacing: 0) {
                
                RoundedRectangle(cornerRadius: 6.0)
                    .foregroundColor(Color(hex: 0x91989F))
                    .frame(width: 40.0 ,height: 3.0)
                    .opacity(0.5)
                    .padding(.bottom, 3)
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(questionListName), id: \.self) { char in
                            BoldText(text: String(char), width: 1, color: Color.black, size: 25, kerning: 2)
                        }
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(questionListName), id: \.self) { char in
                            Text(String(char)).font(.custom("FZSSJW--GB1-0", size: 15)).foregroundColor(.black)
                        }
                    }
                }
            }
        })
    }
}

struct QuestionListTab_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListTab()
    }
}
