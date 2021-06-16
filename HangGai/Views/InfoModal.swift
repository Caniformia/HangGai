//
//  InfoModal.swift
//  HangGai
//
//  Created by TakiP on 2021/05/13.
//

import SwiftUI

struct InfoModal: View {
    @Binding var showInfoModal: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    self.showInfoModal = false
                }, label: {
                    Image(systemName: "xmark.circle.fill").resizable()
                            .frame(width: 24.0, height: 24.0)
                }).foregroundColor(colorScheme == .dark ? .white : .black).padding()
            }

            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Text("航").padding(.leading, 40).font(.custom("FZSSJW--GB1-0", size: 120)).offset(y: -20)
                Text("概").padding(.leading, 115).font(.custom("FZSSJW--GB1-0", size: 120)).offset(y: 35)
            }.padding(.bottom, 20)

            Divider().padding(.leading, 40).padding(.trailing, 150).padding(.vertical, 10)

            Text("""
                 或许你望向窗外，
                 会看见白纸叠作的小飞机。
                 漂游、摇转、飞翔，
                 沉入天空。

                 风带走它的身躯,
                 风环抱你的梦。
                 """).padding(.horizontal, 40).font(.title2)

            Spacer()

            HStack {
                Spacer()
                Text("© Team Caniformia, 2021").italic().padding().font(.footnote)
            }
        }
    }
}

struct InfoModal_Previews: PreviewProvider {
    static var previews: some View {
        InfoModal(showInfoModal: .constant(true))
                .preferredColorScheme(.dark)
    }
}
