//
//  Extension.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/14.
//

import Foundation
import SwiftUI

extension Character {
    var isEmoji: Bool {
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}
    
    
extension String {
    var removingDuplicateCharacters: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
    
    mutating func removeDuplicate() {
        self = self.removingDuplicateCharacters
    }
}
    

struct BlinkEffect: ViewModifier {
    @State var isOn: Bool = false
    let sizeRange: ClosedRange<CGFloat>
    let opacityRange: ClosedRange<Double>
    let interval: Double

    init(size: ClosedRange<CGFloat>, opacity: ClosedRange<Double>, interval: Double) {
        self.sizeRange = size
        self.opacityRange = opacity
        self.interval = interval
    }

    func body(content: Content) -> some View {
        content
            .opacity(self.isOn ? self.opacityRange.lowerBound : self.opacityRange.upperBound)
            .font(.system(size: self.isOn ? self.sizeRange.lowerBound : self.sizeRange.upperBound))
            .animation(Animation.linear(duration: self.interval).repeatForever())
            .onAppear(perform: {
                self.isOn = true
            })
    }
}

extension View {
    func blinkEffect(size: ClosedRange<CGFloat> = 30...100,
                     opacity: ClosedRange<Double> = 0.1...1,
                     interval: Double = 1.0) -> some View {
        self.modifier(BlinkEffect(size: size, opacity: opacity, interval: interval))
    }
}

