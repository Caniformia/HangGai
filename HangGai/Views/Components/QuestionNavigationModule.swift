//
//  QuestionNavigationModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

struct QuestionNavigationModule: View {
    @EnvironmentObject var questionManager: QuestionManager
    @State private var jumpToQuestionID: String = ""
    @State private var showChapterList: Bool = true

    @Binding var showChapterPopover: Bool

    @Environment(\.colorScheme) var colorScheme

    private var intToCharacter: [String] = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
    private var chapterName: [String] = ["", "航空航天发展概况", "飞行器飞行原理", "飞行器动力装置", "飞行器机载设备及飞行控制", "飞行器构造", "附录"]

    private var nowQuestionIndex: String {
        "\(questionManager.questionIndex)" + "/" + "\(questionManager.questionAmount())"
    }

    init(showChapterPopover: Binding<Bool>) {
        self._showChapterPopover = showChapterPopover
    }

    var body: some View {
        VStack(alignment: .leading) {
            if showChapterPopover {
                VStack(alignment: .leading) {
                    //QuestionChapterStatus(questionChapterID: self.questionManager.questionChapter(), isIncrement: self.questionManager.getIsIncrement())
                    TextField("请输入想跳转的题号", text: $jumpToQuestionID)
                            .font(.navigationNotice)
                            .keyboardType(.numberPad)
                            .padding()
                            //.textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(colorScheme == .dark ? Color.white : .black, lineWidth: 1).frame(height: 40.0))
                            .modifier(JumpQuestionButton(text: $jumpToQuestionID, questionManager: questionManager))
                }
                        .animation(.easeInOut)
                        .transition(.expandVertically)
                        .padding(.bottom, 2)
            }
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        /*
                        Button(action: {
                            showChapterList.toggle()
                        }, label: {*/
                        ProgressBarQuestionChapter(questionChapterID: questionManager.questionChapter(), isIncrement: questionManager.getIsIncrement())
                                .transition(.opacity)
                                .contextMenu(ContextMenu(menuItems: {
                                    ForEach(1..<7) { number in
                                        Button(action: {
                                            withAnimation(.easeInOut(duration: 2.0)) {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                                    questionManager.setQuestionIndex(toSetQuestionIndex:
                                                                                        questionManager.getIndexByQuestionId(questionId: questionManager.getChapterQuestions(chapterId: number).min() ?? 0))
                                                }
                                            }
                                        }, label: {
                                            Text("第\(intToCharacter[number])章  \(chapterName[number])")
                                                    .font(.headline)
                                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                        })
                                    }
                                })
                                )
                        //})
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.showChapterPopover.toggle()
                            }
                        }, label: {
                            Text("\(questionManager.questionIndex)")
                                    .font(.headline).foregroundColor(colorScheme == .dark ? .white : .black)
                                    .kerning(4.0)
                                    .opacity(0.8)
                            Text("/" + "\(questionManager.questionAmount())")
                                    .font(.headline).foregroundColor(colorScheme == .dark ? .white : .black)
                                    .kerning(4.0)
                        })
                        /*
                        Text("顺序模式")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white).padding(.vertical, 3).padding(.horizontal, 5)
                            .background(Capsule().foregroundColor(Color(red: 241.0/256.0, green: 124.0/256.0, blue: 103.0/256.0, opacity: 1.0)))*/
                    }
                            .padding(.bottom, 4)
                    CustomProgressBar(value: Double(questionManager.questionIndex) / Double(questionManager.questionAmount()))
                            .frame(height: 10)
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
        }
    }
}

struct QuestionNavigationModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionNavigationModule(showChapterPopover: .constant(true))
    }
}
