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
                Circle()
                    .opacity(0.5)

                Text(card.content)
                    .font(.system(size: 40))

            }
            .cardify(isFaceUp: card.isFaceUp)
            .foregroundColor(.red)
            //.opacity((card.isMatched && !card.isFaceUp) ? 0 : 1)
        }
    }
}

