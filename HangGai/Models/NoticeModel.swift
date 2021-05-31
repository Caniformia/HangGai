//
//  NoticeModel.swift
//  HangGai
//
//  Created by TakiP on 2021/5/31.
//

import Foundation

class CustomNotice {
    var rawData: String
    
    init(rawData: String) {
        self.rawData = rawData
    }
    
    func toString() -> String {
        return self.rawData
    }
}
