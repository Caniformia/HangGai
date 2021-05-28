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
                    .stroke(currentForegroundColor, lineWidth: 0.8)
            )
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
    private var fontSize: CGFloat
    private var answerTagID: Int
    @State private var optionSelected: Bool
    private var backgroundColor: Color
    private var foregroundColor: Color
    private var isAnswer: Bool
    private var isMemoryMode: Bool
    private let title: String
    @ObservedObject var questionManager: QuestionManager
    
    var displayBackgroundColor: Color {
        return (isMemoryMode && isAnswer) ? foregroundColor : ((isMemoryMode && !isAnswer) ? backgroundColor : (optionSelected ? foregroundColor : backgroundColor))
    }
    var displayForegroundColor: Color {
        return (isMemoryMode && isAnswer) ? backgroundColor : ((isMemoryMode && !isAnswer) ? foregroundColor : (optionSelected ? backgroundColor : foregroundColor))
    }
    
    var answerTag: String {
        if self.answerTagID > -1 && self.answerTagID < 26 {
            return String(UnicodeScalar(answerTagID + Int(("A" as UnicodeScalar).value)) ?? "Z")
        } else {
            return "Z"
        }
    }
    
    init(backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         fontSize: CGFloat = 15,
         answerTagID: Int = 0,
            questionManager: QuestionManager) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.fontSize = fontSize
        self.answerTagID = answerTagID
        self.questionManager = questionManager
        
        if let selectedQuestion = questionManager.selectedQuestion { // Avoid being updated because of the observer for /* selectedQuestion */
            self.isAnswer = selectedQuestion.answer.contains(answerTagID)
            self.title = selectedQuestion.options[answerTagID]
        } else {
            self.isAnswer = false
            self.title = ""
        }
        self.isMemoryMode = questionManager.getIsMemoryMode()
        self.optionSelected = questionManager.getUserAnswer().contains(answerTagID)
    }
    
    var body: some View {
        HStack {
            Button(action: {
                if !isMemoryMode {
                    self.questionManager.toggleUserAnswer(answerTagID: self.answerTagID)
                    self.optionSelected.toggle() // Avoid using compute attribute, as we need it to be updated "lazily", which means "not to be updated when switch to a new question".
                }
            }) {
                HStack(alignment: .center){
                    Text(self.answerTag).padding(.leading).font(Font.custom("FZSSJW--GB1-0", size: 20))
                    BoldText(text: self.title,width: 1,color: displayForegroundColor,size:15,kerning: 0).padding(.horizontal)
                    //Text(self.title).padding(.horizontal)
                    Spacer()
                }
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: displayBackgroundColor,
                                          foregroundColor: displayForegroundColor,
                                          isDisabled: false,
                                          fontSize: fontSize,
                                          cornerRadius: 15))
        }
        .frame(maxWidth:.infinity)
    }
    
}

struct JumpQuestionButton: ViewModifier
{
    @Binding var text: String
    @ObservedObject var questionManager: QuestionManager
    
    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content
            Button(action: {
                if let toSetQuestionIndex = Int(self.text) {
                    questionManager.setQuestionIndex(toSetQuestionIndex: toSetQuestionIndex)
                }
                UIApplication.shared.endEditing()
            }, label:{
                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                    .resizable()
                    .foregroundColor(Color.black)
                    .frame(width: 24, height: 24)
            })
            .padding(.trailing, 15)
        }
    }
}
