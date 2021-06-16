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
    let font: Font
    let cornerRadius: CGFloat

    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
                .padding(.vertical, 10)
                .foregroundColor(currentForegroundColor)
                .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
                // This is the key part, we are using both an overlay as well as cornerRadius
                .cornerRadius(cornerRadius)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(currentForegroundColor, lineWidth: 1))
                .font(font)
    }
}

struct LargeButton: View {

    private static let buttonHorizontalMargins: CGFloat = 20

    var backgroundColor: Color
    var foregroundColor: Color
    var font: Font

    private let title: String
    private let action: () -> Void

    // It would be nice to make this into a binding.
    private let disabled: Bool

    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         font: Font = .body,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.action = action
        self.disabled = disabled
        self.font = font
    }

    var body: some View {
        Button(action: action) {
            Text(title).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
                .buttonStyle(LargeButtonStyle(backgroundColor: backgroundColor,
                        foregroundColor: foregroundColor,
                        isDisabled: disabled,
                        font: font,
                        cornerRadius: 20))
                .disabled(disabled)
    }
}

struct AnswerButton: View {
    private var font: Font
    private var answerTagID: Int
    @State private var optionSelected: Bool = false
    private var backgroundColor: Color
    private var foregroundColor: Color
    private var isAnswer: Bool
    private var isMemoryMode: Bool
    private let title: String
    @ObservedObject var questionManager: QuestionManager
    private var isAnswered: Bool
    private var hasBeenSelected: Bool

    var displayBackgroundColor: Color {
        isAnswered ? (isAnswer ? foregroundColor : backgroundColor) : ((isMemoryMode && isAnswer) ? foregroundColor : ((isMemoryMode && !isAnswer) ? backgroundColor : (optionSelected ? foregroundColor : backgroundColor)))
    }
    var displayForegroundColor: Color {
        isAnswered ? (isAnswer ? backgroundColor : foregroundColor) : ((isMemoryMode && isAnswer) ? backgroundColor : ((isMemoryMode && !isAnswer) ? foregroundColor : (optionSelected ? backgroundColor : foregroundColor)))
    }

    var answerTag: String {
        if answerTagID > -1 && answerTagID < 26 {
            return String(UnicodeScalar(answerTagID + Int(("A" as UnicodeScalar).value)) ?? "Z")
        } else {
            return "Z"
        }
    }

    init(backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         font: Font = .body,
         answerTagID: Int = 0,
         questionManager: QuestionManager,
         isAnswered: Bool,
         hasBeenSelected: Bool
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.answerTagID = answerTagID
        self.questionManager = questionManager
        self.isAnswered = isAnswered

        if let selectedQuestion = questionManager.selectedQuestion { // Avoid being updated because of the observer for /* selectedQuestion */
            isAnswer = selectedQuestion.answer.contains(answerTagID)
            title = selectedQuestion.options[answerTagID]
        } else {
            isAnswer = false
            title = ""
        }
        isMemoryMode = questionManager.getIsMemoryMode()
        self.hasBeenSelected = hasBeenSelected
        optionSelected = questionManager.getUserAnswer().contains(answerTagID)
    }

    var body: some View {
        HStack {
            Button(action: {
                if !isMemoryMode {
                    questionManager.toggleUserAnswer(answerTagID: answerTagID)
                    self.optionSelected.toggle() // Avoid using compute attribute, as we need it to be updated "lazily", which means "not to be updated when switch to a new question".
                }
            }) {
                HStack(alignment: .center) {
                    Text(answerTag).padding(.leading).font(.title2)
                    if (!isAnswered || isAnswer) {
                        BoldText(text: title, font: font, color: displayForegroundColor, width: 1, kerning: 0)
                                .padding(.horizontal)
                    } else {
                        Text(title)
                                .font(font)
                                .lineSpacing(5)
                                .foregroundColor(displayForegroundColor)
                                .padding(.horizontal)
                    }
                    //Text(self.title).padding(.horizontal)
                    Spacer()
                    if isAnswered {
                        if isAnswer {
                            Image(systemName: "checkmark.circle.fill").resizable()
                                    .frame(width: 24, height: 24).padding(.trailing)
                        } else {
                            if hasBeenSelected && !isAnswer {
                                Image(systemName: "xmark.circle").resizable()
                                        .frame(width: 24, height: 24).padding(.trailing)
                            } else {
                                Spacer().frame(width: 24, height: 24).padding(.trailing)
                            }
                        }
                    }
                }
            }
                    .buttonStyle(LargeButtonStyle(backgroundColor: displayBackgroundColor,
                            foregroundColor: displayForegroundColor,
                            isDisabled: isAnswered && !hasBeenSelected && !isAnswer,
                            font: font,
                            cornerRadius: 15))
                    .opacity(isAnswered ? (isAnswer ? 1 : (hasBeenSelected ? 0.9 : 0.2)) : 1)
        }
    }
}

struct JumpQuestionButton: ViewModifier {
    @Binding var text: String
    @ObservedObject var questionManager: QuestionManager
    @Environment(\.colorScheme) var colorScheme

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            Button(action: {
                if let toSetQuestionIndex = Int(text) {
                    questionManager.setQuestionIndex(toSetQuestionIndex: toSetQuestionIndex)
                }
                UIApplication.shared.endEditing()
            }, label: {
                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .resizable()
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .frame(width: 22, height: 22)
            })
                    .padding(.trailing, 13)
                    .opacity(0.8)
        }
    }
}
