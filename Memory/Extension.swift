//
//  Extension.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/14.
//

import Foundation

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
    

