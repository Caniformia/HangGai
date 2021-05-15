//
//  SwipeGestureManager.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import SwiftUI

class SwipeGestureManager: ObservableObject {
    let detectDirectionalDrags = DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
        .onEnded { value in
            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                print("left swipe")
            }
            else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                print("right swipe")
            }
            else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                print("up swipe")
            }
            else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                print("down swipe")
            }
            else {
                print("no clue")
            }
        }
}
