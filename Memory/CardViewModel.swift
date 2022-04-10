//
//  CardViewModel.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/10.
//

import Foundation

class CardViewModel: ObservableObject {
    
    @Published var cardModel: CardModel<String>
    
    
    static let emojis = ["🚗","🚀","✈️","🚁","🛥","⚓️","🦼","🚛","🚒","🧩","🎲","🎹","🎨","🏅"]
    
    init() {
        cardModel = Self.createEmojiCard()
    }
    
    static private func createEmojiCard() -> CardModel<String> {
        CardModel(numberOfPairs: 5, createCardContent: { idx in
            emojis[idx]
        })
    }
    
    var cards: [CardModel<String>.Card] {
        cardModel.cards
    }
    
}
