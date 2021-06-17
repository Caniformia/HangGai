//
//  QuestionListTab.swift
//  HangGai
//
//  Created by TakiP on 2021/5/31.
//

import SwiftUI

struct QuestionListTab: View {
    let questionListTable: [(id: Int, name: String, key: String, description: String)] = [
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

    @Binding var selectedQuestionList: Int
    @Binding var showQuestionListTab: Bool
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var userDaraManager: UserDataManager

    @ViewBuilder func descriptionText(of text: String, id: Int) -> some View {
        Text(text)
                .opacity(selectedQuestionList == id ? 1 : 0)
                .font(.body)
                .padding(selectedQuestionList == id ? 10 : 0)
                .lineSpacing(2.5)
                .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(colorScheme == .dark ? Color.white : .black)
                        .foregroundColor(colorScheme == .light ? Color.white : .black)
                )
                .frame(maxWidth: selectedQuestionList == id ? nil : 0, maxHeight: selectedQuestionList == id ? nil : 0)
                .padding([.top, .leading], selectedQuestionList == id ? 5 : 0)
                .padding(.trailing, selectedQuestionList == id ? 15 : 0)
    }

    var body: some View {
        VStack {
            if horizontalSizeClass == .compact {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(questionListTable, id: \.self.id) { (id, name, key, description) in
                            HStack(alignment: .top) {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selectedQuestionList = id
                                        questionManager.updateQuestionList(identifier: key)
                                    }
                                }, label: {
                                    VStack(alignment: .center) {
                                        RoundedRectangle(cornerRadius: 6)
                                                .foregroundColor(Color(hex: 0x91989F))
                                                .frame(width: selectedQuestionList == id ? 40 : 30, height: 3)
                                                .opacity(0.5)
                                                .padding(.bottom, 3)
                                        HStack(alignment: .top, spacing: 0) {
                                            VStack(alignment: .center, spacing: 0) {
                                                ForEach(Array(name), id: \.self) { char in
                                                    AnimatableBoldText(
                                                            text: String(char),
                                                            fontName: "SourceHanSerifCN-Medium",
                                                            id: id,
                                                            selectedId: $selectedQuestionList,
                                                            color: colorScheme == .dark ? .white : .black,
                                                            width: 1,
                                                            kerning: 2)
                                                }
                                            }
                                            VStack(alignment: .center, spacing: 0) {
                                                if questionManager.getQuestionListCount(identifier: key) != 0 {
                                                    ForEach(Array("共\(questionManager.getQuestionListCount(identifier: key))题"), id: \.self) { char in
                                                        Text(String(char))
                                                                .font(.caption1)
                                                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                                    }
                                                } else {
                                                    ForEach(Array("无题目"), id: \.self) { char in
                                                        Text(String(char))
                                                                .font(.caption1)
                                                    }
                                                }
                                            }
                                        }
                                    }.frame(height: 160, alignment: .top)
                                }
                                ).disabled(questionManager.getQuestionListCount(identifier: key) == 0)
                                descriptionText(of: description, id: id)
                            }.opacity(selectedQuestionList == id ? 1 : ((questionManager.getQuestionListCount(identifier: key) == 0) ? 0.1 : 1))
                        }
                    }
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(questionListTable, id: \.self.id) { (id, name, key, description) in
                            VStack(alignment: .leading) {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selectedQuestionList = id
                                        questionManager.updateQuestionList(identifier: key)
                                    }
                                }, label: {
                                    HStack(alignment: .center) {
                                        RoundedRectangle(cornerRadius: 6)
                                                .foregroundColor(Color(hex: 0x91989F))
                                                .frame(width: 3, height: selectedQuestionList == id ? 55 : 40)
                                                .opacity(0.5)
                                                .padding(.trailing, 3)
                                        VStack(alignment: .leading, spacing: 0) {
                                            AnimatableBoldText(
                                                    text: name,
                                                    fontName: "SourceHanSerifCN-Medium",
                                                    id: id,
                                                    selectedId: $selectedQuestionList,
                                                    color: colorScheme == .dark ? .white : .black,
                                                    width: 1,
                                                    kerning: 2)
                                            if questionManager.getQuestionListCount(identifier: key) != 0 {
                                                Text("共\(questionManager.getQuestionListCount(identifier: key))题")
                                                        .font(.caption1)
                                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                            } else {
                                                Text("无题目")
                                                        .font(.caption1)
                                            }
                                        }
                                    }
                                }
                                ).disabled(questionManager.getQuestionListCount(identifier: key) == 0)
                                descriptionText(of: description, id: id)
                            }.opacity(selectedQuestionList == id ? 1 : ((questionManager.getQuestionListCount(identifier: key) == 0) ? 0.1 : 1))
                        }
                    }
                }
            }
            HStack {
                Spacer()
                Text("© Team Caniformia, 2021").italic().padding().font(.system(.footnote))
            }
        }
    }
}

struct QuestionListTab_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListTab(selectedQuestionList: .constant(0), showQuestionListTab: .constant(true))
                .environmentObject(UserDataManager())
                .environmentObject(QuestionManager())
                .environmentObject(NoticeManager())
    }
}
