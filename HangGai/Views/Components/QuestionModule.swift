//
//  QuestionModule.swift
//  HangGai
//
//  Created by TakiP on 2021/5/15.
//

import Foundation
import SwiftUI

struct QuestionModule: View {
    @EnvironmentObject var questionManager: QuestionManager
    @EnvironmentObject var userDataManager: UserDataManager

    @State var startPos: CGPoint = .zero
    @State var isDragging = true

    @Binding var isInitialized: Bool

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    init(isInitialized: Binding<Bool>) {
        self._isInitialized = isInitialized
    }

    @ViewBuilder func question(for selectedQuestion: Question) -> some View {
        if selectedQuestion.imgName == "" {
            VStack(alignment: .leading) {
                Text(selectedQuestion.questionText)
                        .font(.title1)
                        .lineSpacing(10)
                        .minimumScaleFactor(0.00001)
            }.frame(height: 200).padding([.horizontal, .bottom])
        } else {
            VStack(alignment: .leading) {
                Text(selectedQuestion.questionText)
                        .font(.title1)
                        .lineSpacing(10)
                        .minimumScaleFactor(0.00001)
                Image(selectedQuestion.imgName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .border(colorScheme == .dark ? Color.white : .black, width: 0.8)
            }.frame(minHeight: 200).padding([.horizontal, .bottom])
        }
    }

    @ViewBuilder func options(for selectedQuestion: Question) -> some View {
        VStack(alignment: .center) {
            ForEach(selectedQuestion.options.indices) { optionIndex in
                AnswerButton(backgroundColor: colorScheme == .light ? .white : .black,
                        foregroundColor: colorScheme == .dark ? .white : .black,
                        font: .body,
                        answerTagID: optionIndex,
                        questionManager: questionManager,
                        isAnswered: questionManager.isQuestionAnswered(questionId: selectedQuestion.id),
                        hasBeenSelected: userDataManager.getQuestionChoices(questionId: selectedQuestion.id)?.contains(optionIndex) ?? false)
                        .padding(.vertical, 5)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
        }.padding(.horizontal)
    }

    var body: some View {
        if let selectedQuestion = questionManager.selectedQuestion {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    if true {// horizontalSizeClass == .compact {
                        VStack(alignment: .leading) {
                            question(for: selectedQuestion)
                            options(for: selectedQuestion)
                        }
                                .transition(questionManager.isIncrement ? (.moveOutAndIn) : (.moveInAndOut))
                                .id("\(selectedQuestion.id).\(questionManager.questionAmount())")
                    } else {
                        HStack {
                            question(for: selectedQuestion)
                            options(for: selectedQuestion)
                        }
                                .transition(questionManager.isIncrement ? (.moveOutAndIn) : (.moveInAndOut))
                                .id("\(selectedQuestion.id).\(questionManager.questionAmount())")
                    }
                }
                        .blur(radius: questionManager.playAnswerVerifyAnimation ? 1 : 0)
                        .opacity(questionManager.playAnswerVerifyAnimation ? 0.05 : 1)
                if questionManager.playAnswerVerifyAnimation {
                    BigCorrectMark(correct: questionManager.isAnswerRight).transition(.opacity)
                }
            }
                    .highPriorityGesture(DragGesture()
                            .onChanged { gesture in
                                if isDragging {
                                    self.startPos = gesture.location
                                    self.isDragging.toggle()
                                }
                            }
                            .onEnded { gesture in
                                let xDist = abs(gesture.location.x - startPos.x)
                                let yDist = abs(gesture.location.y - startPos.y)
                                if isInitialized {
                                    if startPos.x > gesture.location.x + 20 && yDist < xDist {
                                        if questionManager.getIsMemoryMode() {
                                            questionManager.incrementQuestionIndex()
                                            if questionManager.isDisplayingAnswer {
                                                questionManager.toggleMemoryMode()
                                                questionManager.isDisplayingAnswer.toggle()
                                            }
                                        } else {
                                            questionManager.swipedScreenRight()
                                        }
                                    } else if startPos.x < gesture.location.x - 20 && yDist < xDist {
                                        questionManager.decrementQuestionIndex()
                                    }
                                }
                                self.isDragging.toggle()
                            }
                    )
                    .animation(Animation.easeInOut(duration: AnimationSettingManager().getVerifyAnswerDuration()).delay(AnimationSettingManager().getVerifyAnswerDelay()), value: questionManager.playAnswerVerifyAnimation)
        } else {
            Text("No Question.")
        }
    }
}

struct QuestionModule_Previews: PreviewProvider {
    static var previews: some View {
        QuestionModule(isInitialized: .constant(true))
                .environmentObject(UserDataManager())
                .environmentObject(QuestionManager())
                .environmentObject(NoticeManager())
    }
}
