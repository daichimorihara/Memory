//
//  CardView.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/11.
//

import SwiftUI

struct CardView: View {

    var card: CardModel<String>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white

                Circle()
                    .opacity(0.5)

                Text(card.content)
                    .font(.system(size: 40))

                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: 1).strokeBorder(lineWidth: 1)
                } else {
                    RoundedRectangle(cornerRadius: 1)
                }

            }
            .foregroundColor(.red)
            .opacity((card.isMatched && !card.isFaceUp) ? 0 : 1)
        }
    }
}

