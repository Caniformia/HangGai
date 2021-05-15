//
//  SubmitButton.swift
//  Snore
//
//  Created by TakiP on 2020/11/22.
//

import SwiftUI

//From @Zorayr on StackOverflow

struct LargeButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    let fontSize: CGFloat
    let cornerRadius: CGFloat
    
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding(.vertical,10)
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(currentForegroundColor, lineWidth: 1)
            )
            .padding([.top, .bottom], 10)
            .font(Font.custom("FZSSJW--GB1-0", size: fontSize))
    }
}

struct LargeButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var backgroundColor: Color
    var foregroundColor: Color
    var fontSize: CGFloat
    
    private let title: String
    private let action: () -> Void
    
    // It would be nice to make this into a binding.
    private let disabled: Bool
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         fontSize: CGFloat = 15,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.action = action
        self.disabled = disabled
        self.fontSize = fontSize
    }
    
    var body: some View {
        HStack {
            //Spacer(minLength: LargeButton.buttonHorizontalMargins)
            Button(action:self.action) {
                Text(self.title)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          isDisabled: disabled,
                                          fontSize: fontSize,
                                          cornerRadius: 6))
            .disabled(self.disabled)
            //Spacer(minLength: LargeButton.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
    }
}

struct AnswerButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var fontSize: CGFloat
    var answerTagID: Int
    @State private var buttonTapped = false
    var backgroundColor: Color
    var foregroundColor: Color
    var isAnswer: Bool
    
    var displayBackgroundColor: Color {
        return (disabled && isAnswer) ? foregroundColor : ((disabled && !isAnswer) ? backgroundColor : (buttonTapped ? foregroundColor : backgroundColor))
    }
    var displayForegroundColor: Color {
        return (disabled && isAnswer) ? backgroundColor : ((disabled && !isAnswer) ? foregroundColor : (buttonTapped ? backgroundColor : foregroundColor))
    }
    
    
    private let title: String
    
    var answerTag: String {
        if self.answerTagID > -1 && self.answerTagID < 26 {
            return String(UnicodeScalar(answerTagID + Int(("A" as UnicodeScalar).value)) ?? "Z")
        } else {
            return "Z"
        }
    }
    
    // It would be nice to make this into a binding.
    private let disabled: Bool
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         fontSize: CGFloat = 15,
         answerTagID: Int = 0,
         isAnswer: Bool) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.disabled = disabled
        self.fontSize = fontSize
        self.answerTagID = answerTagID
        self.isAnswer = isAnswer
    }
    
    var body: some View {
        HStack {
            //Spacer(minLength: LargeButton.buttonHorizontalMargins)
            Button(action: {
                if !disabled {
                    self.buttonTapped.toggle()
                }
            }) {
                HStack(alignment: .center){
                    Text(self.answerTag).padding(.leading).font(Font.custom("FZSSJW--GB1-0", size: 20))
                    Text(self.title).padding(.horizontal)
                    Spacer()
                }
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: displayBackgroundColor,
                                          foregroundColor: displayForegroundColor,
                                          isDisabled: false,
                                          fontSize: fontSize,
                                          cornerRadius: 15))
            //Spacer(minLength: LargeButton.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
        .onChange(of: disabled, perform: { value in
            self.buttonTapped = false
        })
    }
    
}
