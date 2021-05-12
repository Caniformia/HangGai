//
//  CustomFuncs.swift
//  Snore
//
//  Created by TakiP on 2020/11/23.
//

import SwiftUI


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
