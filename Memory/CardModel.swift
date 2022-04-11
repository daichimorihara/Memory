//
//  CardModel.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/10.
//

import Foundation
import UIKit

struct CardModel<CardContent> where CardContent: Equatable {
    var cards: [Card]
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for index in 0..<numberOfPairs {
            let content = createCardContent(index)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchingIndex = indexOfOneAndOnlyFaceUp {
                if cards[chosenIndex].content == cards[potentialMatchingIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchingIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUp = chosenIndex
            }
        }
    }
    
    var indexOfOneAndOnlyFaceUp: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp == true }).onlyOne }
        set { cards.indices.forEach({ cards[$0].isFaceUp = ( $0 == newValue ) }) }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id = UUID()
    }
}

extension Array {
    var onlyOne: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
