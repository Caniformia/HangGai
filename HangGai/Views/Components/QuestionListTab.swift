//
//  QuestionListTab.swift
//  HangGai
//
//  Created by TakiP on 2021/5/31.
//

import SwiftUI

struct QuestionListTab: View {
    private var questionListTable: [(id: Int, name: String, key: String, description: String)] = [
        (0,
                "顺序刷题",
                "Meta",
                """
                饱含出题人爱意的
                航概题库特大分享装。
                一题不漏、
                全部做完的话，
                会变成折翼天使哦。
                """
        ),
        (1,
                "收藏题单",
                "Favorites",
                """
                究竟为什么、
                为什么那个时候，
                会按下收藏键呢？
                总不会是根本不会做吧，
                不 会 吧 不 会 吧？
                """
        ),
        (2,
                "错题列表",
                "Incorrects",
                """
                所谓温故而知新，
                只要有朝一日能清空
                这个列表的话，
                你就是航概强强人了！
                （大概？）
                """
        ),
        (3,
                "随机刷题",
                "Random",
                """
                把命运交给随机数！
                适合“爷嘛也不想考虑，
                就想随便做做”的人群！
                每次进入都不一样，
                很可能遇见老朋友！
                """
        )
        /*
        ,
        (4,
         "历史错题",
         "BlackHistory",
         """
         记载着一切既往罪孽
         与过错的禁忌之书，
         似乎又叫做“黑历史”诶。
         如果决心想消除羞耻的话，
         可以去设置页全部清空哦。
         """
        )
        */
    ]

    @State var selectedQuestionList: Int = 0

    @Binding var showQuestionListTab: Bool

    @Environment(\.colorScheme) var colorScheme

    init(showQuestionListTab: Binding<Bool>) {
        self._showQuestionListTab = showQuestionListTab
    }

    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var userDaraManager: UserDataManager
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(questionListTable, id: \.self.id) { (id, name, key, description) in
                        HStack(alignment: .top, spacing: 0) {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    selectedQuestionList = id
                                    questionManager.updateQuestionList(identifier: key)
                                }
                            }, label: {
                                VStack(alignment: .leading, spacing: 0) {
                                    RoundedRectangle(cornerRadius: 6)
                                            .foregroundColor(Color(hex: 0x91989F))
                                            .frame(width: selectedQuestionList == id ? 40 : 30, height: 3)
                                            .opacity(0.5)
                                            .padding(.bottom, 3)
                                    HStack(alignment: .top, spacing: 0) {
                                        VStack(alignment: .leading, spacing: 0) {
                                            ForEach(Array(name), id: \.self) { char in
                                                BoldText(text: String(char),
                                                         font: selectedQuestionList == id ? .selectedQuestionList : .caption1,
                                                         color: colorScheme == .dark ? .white : .black,
                                                         width: 1,
                                                         kerning: 2)
                                            }
                                        }
                                        VStack(alignment: .center, spacing: 0) {
                                            if questionManager.getQuestionListCount(identifier: key) != 0 {
                                                ForEach(Array("共\(questionManager.getQuestionListCount(identifier: key))题"), id: \.self) { char in
                                                    Text(String(char)).font(.caption1).foregroundColor(colorScheme == .dark ? .white : .black)
                                                }
                                            } else {
                                                ForEach(Array("无题目"), id: \.self) { char in
                                                    Text(String(char)).font(.caption1).foregroundColor(colorScheme == .dark ? .white : .black)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            )
                                    .disabled(questionManager.getQuestionListCount(identifier: key) == 0)
                            Text(description)
                                    .opacity(selectedQuestionList == id ? 1 : 0)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .font(.headline)
                                    .padding(.horizontal, selectedQuestionList == id ? 7.5 : 0)
                                    .padding(.vertical, selectedQuestionList == id ? 10.5 : 0)
                                    .lineSpacing(2.5)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                            .stroke(colorScheme == .dark ? Color.white : .black)
                                            .foregroundColor(colorScheme == .light ? Color.white : .black)
                                    )
                                    .frame(maxWidth: selectedQuestionList == id ? nil : 0, maxHeight: 116)
                                    .padding(.leading, selectedQuestionList == id ? 5 : 0)
                                    .padding(.trailing, selectedQuestionList == id ? 15 : 0)
                        }
                                .padding(.trailing, 5)
                                .opacity(selectedQuestionList == id ? 1 : ((questionManager.getQuestionListCount(identifier: key) == 0) ? 0.1 : 1))
                    }
                    Spacer()
                }
            }
            HStack {
                Spacer()
                Text("© Team Caniformia, 2021").italic().padding().font(.system(.footnote))
            }
        }
                .offset(x: 0, y: showQuestionListTab ? 0 : 200)
    }
}

struct QuestionListTab_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListTab(showQuestionListTab: .constant(true))
    }
}
