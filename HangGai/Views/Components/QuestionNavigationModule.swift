//
//  QuestionNavigationModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionNavigationModule: View {
    @ObservedObject var questionManager: QuestionManager
    @State private var showChapterPopover: Bool = false
    @State private var jumpToQuestionID: String = ""
    
    private var nowQuestionIndex: String {
        return "\(questionManager.questionIndex)" + "/" + "\(questionManager.questionAmount())"
    }
    
    init(questionManager: QuestionManager) {
        self.questionManager = questionManager
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        ProgressBarQuestionChapter(questionChapterID: self.questionManager.questionChapter(), isIncrement: self.questionManager.getIsIncrement())
                        Spacer()
                        Text("\(questionManager.questionIndex)").font(.custom("FZSSJW--GB1-0", size: 15)).foregroundColor(.black).kerning(4.0)
                            .opacity(0.8)
                        Text("/" + "\(questionManager.questionAmount())").font(.custom("FZSSJW--GB1-0", size: 15)).foregroundColor(.black).kerning(4.0)
                        /*
                        Text("顺序模式")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white).padding(.vertical, 3).padding(.horizontal, 5)
                            .background(Capsule().foregroundColor(Color(red: 241.0/256.0, green: 124.0/256.0, blue: 103.0/256.0, opacity: 1.0)))
 */
                    }
                    .padding(.bottom, 4)
                    CustomProgressBar(value: Double(questionManager.questionIndex)/Double(questionManager.questionAmount())).frame(height: 15)
                }
            }
            
            /*HStack {
             Button(action: {
             questionManager.decrementQuestionIndex()
             }, label: {
             Image(systemName: "chevron.compact.left").resizable()
             .scaledToFit()
             .frame(maxHeight:16)
             }).foregroundColor(.black)
             Spacer()
             Button(action: {
             withAnimation {
             self.showChapterPopover.toggle()
             }
             }, label: {
             Text("\(questionManager.questionIndex)").font(.custom("FZSSJW--GB1-0", size: 15)).kerning(15.0).foregroundColor(.black)
             BoldText(text: "/" + "\(questionManager.questionAmount())", width: 1, color: Color.black, size: 15.0, kerning: 15.0)
             })
             Spacer()
             Button(action: {
             questionManager.incrementQuestionIndex()
             }, label: {
             Image(systemName: "chevron.compact.right").resizable()
             .scaledToFit()
             .frame(maxHeight:16)
             }).foregroundColor(.black)
             }
             */
            if showChapterPopover {
                VStack(alignment: .leading) {
                    QuestionChapterStatus(questionChapterID: self.questionManager.questionChapter(), isIncrement: self.questionManager.getIsIncrement())
                    TextField("请输入想跳转的题号", text: $jumpToQuestionID)
                        .keyboardType(.numberPad)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 3.5))
                        .modifier(JumpQuestionButton(text: $jumpToQuestionID, questionManager: questionManager))
                }.animation(.easeInOut)
                .transition(.expandVertically)
                .padding(.top)
            }
        }
    }
}

struct QuestionNavigationModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionNavigationModule(questionManager: QuestionManager())
    }
}
