//
//  CardViewModel.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/10.
//

import Foundation

class CardViewModel: ObservableObject {
    
    @Published var cardModel: CardModel<String>
    
    var theme: ThemeModel
    
    //static let emojis = ["🚗","🚀","✈️","🚁","🛥","⚓️","🦼","🚛","🚒","🧩","🎲","🎹","🎨","🏅"]
    
    init(theme: ThemeModel) {
        self.theme = theme
        cardModel = Self.createEmojiCard(with: theme)
    }
    
    static private func createEmojiCard(with theme: ThemeModel) -> CardModel<String> {
        CardModel(numberOfPairs: theme.numbers, createCardContent: { idx in
            theme.emojis.map({ String($0) })[idx]
        })
    }
    
    var cards: [CardModel<String>.Card] {
        cardModel.cards
    }
    
    // Mark - Intents
    func choose(_ card: CardModel<String>.Card) {
        cardModel.choose(card)
    }
    
    func shuffle() {
        cardModel.shuffle()
    }
    
    func restart() {
        cardModel = Self.createEmojiCard(with: theme)
    }
}


