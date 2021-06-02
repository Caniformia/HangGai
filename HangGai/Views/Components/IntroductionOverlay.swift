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
    
    init(isInitialized: Binding<Bool>) {
        self._isInitialized = isInitialized
    }
    
    var body: some View {
        if nowView == 0 {
            VStack(alignment: .leading, spacing: 0){
                
                Spacer()
                HStack {
                    Spacer()
                }
                
                BoldText(text: "欢迎来到——", width: 10.0, color: Color.black, size: 30.0, kerning: 0.0).padding(.horizontal,40)
                    .padding(.bottom, 30.0)
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    Text("航").padding(.leading, 40).font(.custom("FZSSJW--GB1-0", size: 120)).offset(y: -20)
                    Text("概").padding(.leading, 115).font(.custom("FZSSJW--GB1-0", size: 120)).offset(y: 35)
                }.padding(.bottom,20)
                
                Divider().padding(.leading, 40).padding(.trailing,150).padding(.vertical,10)
                HStack(alignment: .center, spacing: 1, content: {
                    Text("请点击右下角的").font(.custom("FZSSJW--GB1-0", size: 20.0))
                    Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                        .frame(width: 17.0, height: 17.0)
                    Text(",").font(.custom("FZSSJW--GB1-0", size: 20.0))
                }).padding(.horizontal,40)
                Text("""
                    
                    由我——
                    来为您次第介绍
                    本APP的使用方式。
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 20.0))
                Text("""
                    （听上去长得很帅的声音）
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 13.0))
                    .padding(.top, 10)
                
                
                Spacer()
                
                HStack{
                    Spacer()
                    Button(action: {
                        isIncrement = true
                        withAnimation(.easeInOut(duration: 1.0 )) {
                            nowView = nowView + 1
                        }
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                            .frame(width: 30.0, height: 30.0)
                    })
                    .foregroundColor(.black)
                    .padding()
                    //Text("@Roife & Taki, 2021").italic().padding().font(.footnote)
                }
            }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
        } else if nowView == 1 {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                HStack {
                    Spacer()
                }
                
                BoldText(text: "首先是基本喔～", width: 10.0, color: Color.black, size: 30.0, kerning: 0.0).padding(.horizontal,40)
                    .padding(.bottom, 30.0)
                
                HStack(alignment: .center, spacing: 1, content: {
                    Text("""
                        点击下方的超——
                        长长长长黑按钮的话，
                        """).font(.custom("FZSSJW--GB1-0", size: 20.0))
                }).padding(.horizontal,40)
                Text("""
                    
                    就可以——
                    砰——提交、
                    乓——验证答案、
                    叮咚——进入下一题喔！
                    
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 20.0))
                Group {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("而且如果").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        ZStack{
                            BoldText(text: "从屏幕右边向左滑", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0).offset(x:160.0).opacity(0.01)
                            BoldText(text: "从屏幕右边向左滑", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0).offset(x:80.0).opacity(0.05)
                            BoldText(text: "从屏幕右边向左滑", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0)
                        }
                        Text("的话,").font(.custom("FZSSJW--GB1-0", size: 20.0))
                    }.padding(.horizontal,40)
                    
                    
                    Text("""
                    
                    也一样可以提交喔～
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 20.0))
                }
                
                
                Text("""
                    
                    反过来，
                    从左向右滑的话
                    就可以往回！
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 20.0))
                
                Text("""
                    （听上去像是魔王的声音）
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 13.0))
                    .padding(.top, 10)
                
                
                Spacer()
                
                HStack{
                    Button(action: {
                        isIncrement = false
                        withAnimation(.easeInOut(duration: 1.0 )) {
                            nowView = nowView - 1
                        }
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                            .frame(width: 30.0, height: 30.0)
                    })
                    .foregroundColor(.black)
                    .padding()
                    Spacer()
                    Button(action: {
                        isIncrement = true
                        withAnimation(.easeInOut(duration: 1.0 )) {
                            nowView = nowView + 1
                        }
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                            .frame(width: 30.0, height: 30.0)
                    })
                    .foregroundColor(.black)
                    .padding()
                    //Text("@Roife & Taki, 2021").italic().padding().font(.footnote)
                }
            }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
        } else if nowView == 2 {
            Group {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    HStack {
                        Spacer()
                    }
                    
                    BoldText(text: "接下来是附加功能。", width: 10.0, color: Color.black, size: 30.0, kerning: 0.0).padding(.horizontal,40)
                        .padding(.bottom, 30.0)
                    Group {
                        HStack(alignment: .center, spacing: 1, content: {
                            Text("""
                        点击左下方的
                        """).font(.custom("FZSSJW--GB1-0", size: 20.0))
                            Image(systemName: "bookmark.circle").resizable()
                                .frame(width: 17.0, height: 17.0)
                            Text(",").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        }).padding(.horizontal,40)
                        Text("""
                    将会收藏
                    您目前所阅览的题目，
                    """)
                            .padding(.horizontal,40)
                            .font(.custom("FZSSJW--GB1-0", size: 20.0))
                        
                        
                        HStack(alignment: .center, spacing: 1, content: {
                            Text("并将其加入").font(.custom("FZSSJW--GB1-0", size: 20.0))
                            BoldText(text: "收藏题单", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0)
                                .overlay(Color.black.frame(height: 1.0).offset(y: 1.0), alignment: Alignment(horizontal: .center, vertical: .bottom))
                            Text("中。").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        }).padding(.horizontal,40)
                    }
                    
                    Group {
                        Text("""
                        
                        此外，
                        """)
                            .padding(.horizontal,40)
                            .font(.custom("FZSSJW--GB1-0", size: 20.0))
                        HStack(alignment: .center, spacing: 1, content: {
                            Text("""
                        若点击左下方的
                        """).font(.custom("FZSSJW--GB1-0", size: 20.0))
                            Image(systemName: "book.circle").resizable()
                                .frame(width: 17.0, height: 17.0)
                            Text(",").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        }).padding(.horizontal,40)
                        
                        
                        HStack(alignment: .center, spacing: 1, content: {
                            Text("将进入").font(.custom("FZSSJW--GB1-0", size: 20.0))
                            BoldText(text: "背题模式", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0)
                                .overlay(Color.black.frame(height: 1.0).offset(y: 1.0), alignment: Alignment(horizontal: .center, vertical: .bottom))
                            Text("。").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        }).padding(.horizontal,40)
                        
                        Text("""
                        
                        该模式下，
                        将直接显示问题的答案。
                        您同样可以通过滑动屏幕
                        或点击下方黑色按钮，
                        来切换题目。
                        """)
                            .padding(.horizontal,40)
                            .font(.custom("FZSSJW--GB1-0", size: 20.0))
                    }
                    
                    Text("""
                    （听上去很让人安心的女性声音）
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 13.0))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            isIncrement = false
                            withAnimation(.easeInOut(duration: 1.0 )) {
                                nowView = nowView - 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                .frame(width: 30.0, height: 30.0)
                        })
                        .foregroundColor(.black)
                        .padding()
                        Spacer()
                        Button(action: {
                            isIncrement = true
                            withAnimation(.easeInOut(duration: 1.0 )) {
                                nowView = nowView + 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                                .frame(width: 30.0, height: 30.0)
                        })
                        .foregroundColor(.black)
                        .padding()
                        //Text("@Roife & Taki, 2021").italic().padding().font(.footnote)
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
                    
                    BoldText(text: "最后就由我来吧！", width: 10.0, color: Color.black, size: 30.0, kerning: 0.0).padding(.horizontal,40)
                        .padding(.bottom, 30.0)
                    Group {
                        HStack(alignment: .center, spacing: 1, content: {
                            Text("""
                        点击右下角的
                        """).font(.custom("FZSSJW--GB1-0", size: 20.0))
                            Image(systemName: "line.horizontal.3.circle").resizable()
                                .frame(width: 17.0, height: 17.0)
                            Text("的话,").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        }).padding(.horizontal,40)
                        Text("""
                    可以打开
                    题单切换列表，
                    
                    目前共有
                    """)
                            .padding(.horizontal,40)
                            .font(.custom("FZSSJW--GB1-0", size: 20.0))
                        
                        
                        HStack(alignment: .center, spacing: 1, content: {
                                BoldText(text: "顺序刷题", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0)
                                    .overlay(Color.black.frame(height: 1.0).offset(y: 1.0), alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("、").font(.custom("FZSSJW--GB1-0", size: 20.0))
                                BoldText(text: "收藏题单", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0)
                                    .overlay(Color.black.frame(height: 1.0).offset(y: 1.0), alignment: Alignment(horizontal: .center, vertical: .bottom))
                                Text("、").font(.custom("FZSSJW--GB1-0", size: 20.0))                    })
                            .padding(.horizontal,40)
                            .padding(.vertical, 5)
                        
                        HStack(alignment: .center, spacing: 1, content: {
                            BoldText(text: "错题列表", width: 200.0, color: Color.black, size: 20.0, kerning: 0.0)
                                .overlay(Color.black.frame(height: 1.0).offset(y: 1.0), alignment: Alignment(horizontal: .center, vertical: .bottom))
                            Text("三个选项可选。").font(.custom("FZSSJW--GB1-0", size: 20.0))
                        }).padding(.horizontal,40)
                    }
                    
                    Group {
                        Text("""
                        
                        最后，
                        长按上方章节名，
                        可以快速切换至
                        所选题单对应章节的第一题。
                        点击题号的话，
                        则可以输入题号跳题。
                        """)
                            .padding(.horizontal,40)
                            .font(.custom("FZSSJW--GB1-0", size: 20.0))
                    }
                    
                    Text("""
                    （感觉像是很有精神的...熊（？）的声音）
                    """).padding(.horizontal,40).font(.custom("FZSSJW--GB1-0", size: 13.0))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            isIncrement = false
                            withAnimation(.easeInOut(duration: 1.0 )) {
                                nowView = nowView - 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                .frame(width: 30.0, height: 30.0)
                        })
                        .foregroundColor(.black)
                        .padding()
                        Spacer()
                        Button(action: {
                            isIncrement = true
                            withAnimation(.easeInOut(duration: 1.0 )) {
                                nowView = nowView + 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.forward.circle.fill").resizable()
                                .frame(width: 30.0, height: 30.0)
                        })
                        .foregroundColor(.black)
                        .padding()
                        //Text("@Roife & Taki, 2021").italic().padding().font(.footnote)
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
                    BoldText(text: "教程就到此为止啦！", width: 10.0, color: Color.black, size: 30.0, kerning: 0.0).padding(.horizontal,40)
                        .padding(.bottom, 15.0)
                    
                    BoldText(text: "祝考试顺利！", width: 10.0, color: Color.black, size: 45.0, kerning: 0.0).padding(.horizontal,40)
                        .padding(.bottom, 10.0)
                    
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Spacer()
                    
                    HStack{
                        Button(action: {
                            isIncrement = false
                            withAnimation(.easeInOut(duration: 1.0 )) {
                                nowView = nowView - 1
                            }
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.backward.circle.fill").resizable()
                                .frame(width: 30.0, height: 30.0)
                        })
                        .foregroundColor(.black)
                        .padding()
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut(duration: 1.0)) {
                            userDataManager.setInitialized()
                                isInitialized = true
                            }
                        }, label: {
                            Image(systemName: "xmark.circle.fill").resizable()
                                .frame(width: 30.0, height: 30.0)
                        }).foregroundColor(.black).padding()
                        //Text("@Roife & Taki, 2021").italic().padding().font(.footnote)
                    }
                }
            }.transition(isIncrement ? .moveOutAndIn : .moveInAndOut)
        }
        
    }
}
