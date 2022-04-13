//
//  ThemeModel.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/13.
//

import Foundation

struct ThemeModel: Identifiable, Codable {
    var name: String
    var emojis: String
    var numbers: Int
    var color: String
    var id = UUID()
}
