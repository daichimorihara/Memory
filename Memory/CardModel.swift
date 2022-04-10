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
    
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id = UUID()
    }
}
