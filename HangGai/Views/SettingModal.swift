//
//  SettingModel.swift
//  HangGai
//
//  Created by TakiP on 2021/5/31.
//

import SwiftUI

struct SettingModal: View {
    
    @EnvironmentObject var userDataManager: UserDataManager
    @EnvironmentObject var questionManager: QuestionManager
    
    @Binding var showSettingModal: Bool
    
    var body: some View {
        VStack(alignment: .center){
            /*
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 4.0).frame(width: showSettingModal ? 30.0 : 10.0 ,height: 5.0).padding(.top, 10).opacity(0.2)
                Spacer()
                
            }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("统计").font(.custom("FZSSJW--GB1-0", size: 50))
                    Divider().frame(width: 100)
                }
                Spacer()
            }.padding(.leading, 20)
            HStack {
                Text("收藏").font(.custom("FZSSJW--GB1-0", size: 30))
                Spacer()
                LargeButton(title: "切换至收藏题单", disabled: userDataManager.favorites.isEmpty, backgroundColor: Color.white, foregroundColor: Color.black, fontSize: 20, action: {
                    questionManager.updateQuestionList(questionIds: userDataManager.getFavorites(), identifier: "Favorites")
                    self.showSettingModal = false
                })
            }.padding(.leading, 20)
            LargeButton(title: "切换至错题列表", disabled: userDataManager.isIncorrectsEmpty, backgroundColor: Color.white, foregroundColor: Color.black, fontSize: 20, action: {
                questionManager.updateQuestionList(questionIds: userDataManager.getIncorrects(), identifier: "Incorrects")
                self.showSettingModal = false
            })
            LargeButton(title: "切换至原始题单", disabled: false, backgroundColor: Color.white, foregroundColor: Color.black, fontSize: 20, action: {
                questionManager.restoreQuestionList()
                self.showSettingModal = false
            })
            */
            Spacer()
        }
    }
}

struct SettingModel_Previews: PreviewProvider {
    static var previews: some View {
        SettingModal(showSettingModal: .constant(true))
    }
}
