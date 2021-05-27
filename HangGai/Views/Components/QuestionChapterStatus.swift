//
//  QuestionChapterStatus.swift
//  HangGai
//
//  Created by TakiP on 2021/5/22.
//

import SwiftUI

struct QuestionChapterStatus: View {
    private var questionChapterID: Int
    private var isIncrement: Bool
    
    private var intToCharacter: [String] = ["零","一","二","三","四","五","六","七","八","九"]
    private var chapterName: [String] = ["","航空航天发展概况","飞行器飞行原理","飞行器动力装置","飞行器机载设备及飞行控制","飞行器构造","附录"]
    
    private var chapterNumber: String {
        return "第" + intToCharacter[questionChapterID] + "章"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.chapterNumber).font(.custom("FZSSJW--GB1-0", size: 20)).foregroundColor(.black)
                .opacity(0.6)
            Text(self.chapterName[questionChapterID]).font(.custom("FZSSJW--GB1-0", size: 25)).foregroundColor(.black)
        }.transition(isIncrement ? (.moveOutAndIn) : (.moveInAndOut))
        .id("\(questionChapterID)")
    }
    
    init(questionChapterID: Int, isIncrement: Bool) {
        self.questionChapterID = questionChapterID
        self.isIncrement = isIncrement
    }
}

struct QuestionChapterStatus_Previews: PreviewProvider {
    static var previews: some View {
        QuestionChapterStatus(questionChapterID: 1, isIncrement: true)
    }
}