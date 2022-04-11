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
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        vm.choose(card)
                    }
            }
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
