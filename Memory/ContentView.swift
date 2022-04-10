//
//  ContentView.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CardViewModel()
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(vm.cards) { card in
                CardView(emoji: card.content)
                    .aspectRatio(2/3, contentMode: .fit)
                    .overlay(RoundedRectangle(cornerRadius: 3)
                        .stroke(.red, lineWidth: 1))
            }
        }
        .padding()
    }
}

struct CardView: View {
    var emoji: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {

                Circle()
                    .opacity(0.5)
                
                Text(emoji)
                    
                    
            }
            .foregroundColor(.red)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
