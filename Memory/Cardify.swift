//
//  Cardify.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/11.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 1)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 1)
            } else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
