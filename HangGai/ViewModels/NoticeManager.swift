//
//  NoticeManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/31.
//

import Foundation
import SwiftUI

class NoticeManager: ObservableObject {
    @Published var noticeIndex: Int

    private var noticeLibrary: [CustomNotice] = [
        CustomNotice(rawData: "小贴士：设置页面可以切换至收藏题单、历史错题等")
    ]

    var selectedNotice: CustomNotice {
        noticeLibrary[noticeIndex]
    }

    func noticeAmount() -> Int {
        noticeLibrary.count
    }

    func updateIndex() {
        noticeIndex = (noticeIndex + 1) % noticeAmount()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            withAnimation {
                self.updateIndex()
            }
        }
    }

    init() {
        noticeIndex = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            withAnimation {
                self.updateIndex()
            }
        }
    }
}
