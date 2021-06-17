//
//  IntroductionOverlay.swift
//  HangGai
//
//  Created by TakiP on 2021/6/2.
//

import SwiftUI

struct IntroductionOverlay: View {
    @EnvironmentObject var userDataManager: UserDataManager

    @State private var nowView: Int = 0
    @State private var isIncrement: Bool = true

    @Binding var isInitialized: Bool

    @Environment(\.colorScheme) var colorScheme

    init(isInitialized: Binding<Bool>) {
        self._isInitialized = isInitialized
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if nowView == 0 {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    HStack {
                        Spacer()
                    }
                    BoldText(text: "欢迎来到——", font: .title1, color: colorScheme == .dark ? .white : .black, width: 10, kerning: 0)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 30)
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Text("航").padding(.leading, 40).offset(y: -20)
                                .font(.custom("SourceHanSerifCN-Regular", size: 120, relativeTo: .largeTitle))
                        Text("概").padding(.leading, 108).offset(y: 50)
                                .font(.custom("SourceHanSerifCN-Regular", size: 120, relativeTo: .largeTitle))
                    }.padding(.bottom, 20)
                    Divider().padding(.leading, 40).padding(.trailing, 150).padding(.vertical, 30)
                    HStack(alignment: .center, spacing: 1, content: {
                        Text("请点击右下角的").font(.headline)
                        Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable().frame(width: 17, height: 17)
                        Text(",").font(.headline)
                    }).padding(.horizontal, 40)
                    Text("""

                         由我——
                         来为您次第介绍
                         本APP的使用方式。
                         """).padding(.horizontal, 40).font(.headline)
                    Text("""
                         （听上去长得很帅的声音）
                         """).padding(.horizontal, 40).font(.body)
                            .padding(.top, 10)
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isIncrement = true
                            withAnimation(.easeInOut(duration: 1)) {
                                nowView = nowView + 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                                    .frame(width: 30, height: 30)
                        })
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                    }
                }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
            } else if nowView == 1 {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    HStack {
                        Spacer()
                    }
                    BoldText(text: "首先是基本喔～", font: .title1, color: colorScheme == .dark ? .white : .black, width: 10, kerning: 0)
                            .padding(.horizontal, 40)
                            .padding(.bottom, 30)
                    HStack(alignment: .center, spacing: 1, content: {
                        Text("""
                             点击下方的超——
                             长长长长黑按钮的话，
                             """).font(.headline)
                    }).padding(.horizontal, 40)
                    Text("""

                         就可以——
                         砰——提交、
                         乓——验证答案、
                         叮咚——进入下一题喔！

                         """).padding(.horizontal, 40).font(.headline)
                    Group {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("而且如果").font(.headline)
                            ZStack {
                                BoldText(text: "从屏幕右边向左滑", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0).offset(x: 160).opacity(0.01)
                                BoldText(text: "从屏幕右边向左滑", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0).offset(x: 80).opacity(0.05)
                                BoldText(text: "从屏幕右边向左滑", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                            }
                            Text("的话,").font(.headline)
                        }.padding(.horizontal, 40)
                        Text("""

                             也一样可以提交喔～
                             """).padding(.horizontal, 40).font(.headline)
                    }
                    Text("""

                         反过来，
                         从左向右滑的话
                         就可以往回！
                         """).padding(.horizontal, 40).font(.headline)
                    Text("""
                         （听上去像是魔王的声音）
                         """).padding(.horizontal, 40).font(.body).padding(.top, 10)
                    Spacer()
                    HStack {
                        Button(action: {
                            isIncrement = false
                            withAnimation(.easeInOut(duration: 1)) {
                                nowView = nowView - 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                    .frame(width: 30, height: 30)
                        })
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                        Spacer()
                        Button(action: {
                            isIncrement = true
                            withAnimation(.easeInOut(duration: 1)) {
                                nowView = nowView + 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                                    .frame(width: 30, height: 30)
                        })
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                    }
                }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
            } else if nowView == 2 {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        HStack {
                            Spacer()
                        }
                        BoldText(text: "接下来是附加功能。", font: .title1, color: colorScheme == .dark ? .white : .black, width: 10, kerning: 0)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 30)
                        Group {
                            HStack(alignment: .center, spacing: 1, content: {
                                Text("""
                                     点击左下方的
                                     """).font(.headline)
                                Image(systemName: "bookmark.circle").resizable().frame(width: 17, height: 17)
                                Text(",").font(.headline)
                            }).padding(.horizontal, 40)
                            Text("""
                                 将会收藏
                                 您目前所阅览的题目，
                                 """).padding(.horizontal, 40).font(.headline)
                            HStack(alignment: .center, spacing: 1, content: {
                                Text("并将其加入").font(.headline)
                                BoldText(text: "收藏题单", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                                        .overlay((colorScheme == .dark ? Color.white : .black).frame(height: 1).offset(y: 1),
                                                alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("中。").font(.headline)
                            }).padding(.horizontal, 40)
                        }
                        Group {
                            Text("""

                                 此外，
                                 """).padding(.horizontal, 40).font(.headline)
                            HStack(alignment: .center, spacing: 1, content: {
                                Text("""
                                     若点击左下方的
                                     """).font(.headline)
                                Image(systemName: "book.circle").resizable().frame(width: 17, height: 17)
                                Text(",").font(.headline)
                            }).padding(.horizontal, 40)
                            HStack(alignment: .center, spacing: 1, content: {
                                Text("将进入").font(.headline)
                                BoldText(text: "背题模式", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                                        .overlay((colorScheme == .dark ? Color.white : .black).frame(height: 1).offset(y: 1),
                                                alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("。").font(.headline)
                            }).padding(.horizontal, 40)
                            Text("""

                                 该模式下，
                                 将直接显示问题的答案。
                                 您同样可以通过滑动屏幕
                                 或点击下方黑色按钮，
                                 来切换题目。
                                 """).padding(.horizontal, 40).font(.headline)
                        }
                        Text("""
                             （听上去很让人安心的女性声音）
                             """).padding(.horizontal, 40).font(.body).padding(.top, 10)
                        Spacer()
                        HStack {
                            Button(action: {
                                isIncrement = false
                                withAnimation(.easeInOut(duration: 1)) {
                                    nowView = nowView - 1
                                }
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                        .frame(width: 30, height: 30)
                            })
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                            Spacer()
                            Button(action: {
                                isIncrement = true
                                withAnimation(.easeInOut(duration: 1)) {
                                    nowView = nowView + 1
                                }
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                                        .frame(width: 30, height: 30)
                            })
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                        }
                    }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
                }
            } else if nowView == 3 {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        HStack {
                            Spacer()
                        }
                        BoldText(text: "最后就由我来吧！", font: .title1, color: colorScheme == .dark ? .white : .black, width: 10, kerning: 0)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 30)
                        Group {
                            HStack(alignment: .center, spacing: 1, content: {
                                Text("""
                                     点击右下角的
                                     """).font(.headline)
                                Image(systemName: "line.horizontal.3.circle").resizable().frame(width: 17, height: 17)
                                Text("的话,").font(.headline)
                            }).padding(.horizontal, 40)
                            Text("""
                                 可以打开
                                 题单切换列表，

                                 目前共有
                                 """).padding(.horizontal, 40).font(.headline)
                            HStack(alignment: .center, spacing: 1, content: {
                                BoldText(text: "顺序刷题", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                                        .overlay((colorScheme == .dark ? Color.white : .black).frame(height: 1).offset(y: 1),
                                                alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("、").font(.headline)
                                BoldText(text: "收藏题单", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                                        .overlay((colorScheme == .dark ? Color.white : .black).frame(height: 1).offset(y: 1),
                                                alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("、").font(.headline)
                            })
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 5)
                            HStack(alignment: .center, spacing: 1, content: {
                                BoldText(text: "错题列表", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                                        .overlay((colorScheme == .dark ? Color.white : .black).frame(height: 1).offset(y: 1),
                                                alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("、").font(.headline)
                                BoldText(text: "随机刷题", font: .headline, color: colorScheme == .dark ? .white : .black, width: 200, kerning: 0)
                                        .overlay((colorScheme == .dark ? Color.white : .black).frame(height: 1).offset(y: 1),
                                                alignment: Alignment(horizontal: .center, vertical: .bottom))
                                
                            }).padding(.horizontal, 40)
                            Text("四个选项可选。").padding(.horizontal, 40).font(.headline)
                        }
                        Group {
                            Text("""

                                 最后，
                                 长按上方章节名，
                                 可以快速切换至
                                 所选题单对应章节的第一题。
                                 点击题号的话，
                                 则可以输入题号跳题。
                                 """).padding(.horizontal, 40).font(.headline)
                        }
                        Text("""
                             （感觉像是很有精神的...熊（？）的声音）
                             """).padding(.horizontal, 40).font(.body).padding(.top, 10)
                        Spacer()
                        HStack {
                            Button(action: {
                                isIncrement = false
                                withAnimation(.easeInOut(duration: 1)) {
                                    nowView = nowView - 1
                                }
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                        .frame(width: 30, height: 30)
                            })
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                            Spacer()
                            Button(action: {
                                isIncrement = true
                                withAnimation(.easeInOut(duration: 1)) {
                                    nowView = nowView + 1
                                }
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                                        .frame(width: 30, height: 30)
                            })
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                        }
                    }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
                }
            } else if nowView == 4 {
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        HStack {
                            Spacer()
                        }
                        BoldText(text: "教程就到此为止啦！", font: .title1, color: colorScheme == .dark ? .white : .black, width: 10, kerning: 0)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 15)
                        BoldText(text: "祝考试顺利！", font: .largeTitle, color: colorScheme == .dark ? .white : .black, width: 10, kerning: 0)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 10)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        HStack {
                            Button(action: {
                                isIncrement = false
                                withAnimation(.easeInOut(duration: 1)) {
                                    nowView = nowView - 1
                                }
                            }, label: {
                                Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                        .frame(width: 30, height: 30)
                            })
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                            Spacer()
                            Button(action: {
                                withAnimation(.easeInOut(duration: 1)) {
                                    userDataManager.setInitialized()
                                    isInitialized = true
                                }
                            }, label: {
                                Image(systemName: "xmark.circle.fill").resizable()
                                        .frame(width: 30, height: 30)
                            }).foregroundColor(colorScheme == .dark ? .white : .black).padding()
                        }
                    }
                }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
            }
        }
                .scrollOnlyOnOverflow()
    }
}

struct IntroductionOverlay_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionOverlay(isInitialized: .constant(true))
    }
}
