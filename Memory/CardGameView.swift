//
//  CardGameView.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/13.
//

import SwiftUI

struct CardGameView: View {
    @StateObject var vm = CardViewModel()
    @Namespace var namespacing
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                cardBody
                
                HStack {
                    shuffleButton
                    Spacer()
                    restartButton
                }
            }
            deck.padding(.bottom)
            
        }
        .padding()
    }
    
    var cardBody: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                ForEach(vm.cards) { card in
                    if undealt(card) || (!card.isFaceUp && card.isMatched) {
                        Color.clear
                    } else {
                        CardView(card: card)
                            .matchedGeometryEffect(id: card.id, in: namespacing)
                            .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                withAnimation {
                                    vm.choose(card)
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    var shuffleButton: some View {
        Button("Shufle") {
            // shuffle function
            withAnimation {
                vm.shuffle()
            }
        }
    }
    
    var restartButton: some View {
        Button("Restart") {
            // restart function
            withAnimation {
                dealt = []
                vm.restart()
            }
        }
    }
    
    @State private var dealt = Set<UUID>()
    
    private func deal(_ card: CardModel<String>.Card) {
        dealt.insert(card.id)
    }
    
    private func undealt(_ card: CardModel<String>.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func delayfunc(_ card: CardModel<String>.Card) -> Double {
        var delay = 0.0
        
        if let index = vm.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) / Double(vm.cards.count)
        }
        
        return delay
    }
    
    
    
    
    var deck: some View {
        ZStack {
            ForEach(vm.cards.filter({ undealt($0) })) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: namespacing)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                    
            }
        }
        .frame(width: 60, height: 90)
        .onTapGesture {
            for card in vm.cards {
                withAnimation(Animation.linear(duration: 0.5).delay(delayfunc(card))) {
                    deal(card)
                }
            }
        }
    }
}

struct CardGameView_Previews: PreviewProvider {
    static var previews: some View {
        CardGameView()
    }
}
