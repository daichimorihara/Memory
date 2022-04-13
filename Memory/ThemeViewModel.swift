//
//  ThemeViewModel.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/13.
//

import Foundation
import SwiftUI

class ThemeViewModel: ObservableObject {
    @Published var themes = [ThemeModel]() {
        didSet {
            storeData()
        }
    }
    
    var userDefaultKey: String {
        "PrivateKey"
    }
    
    init() {
        loadData()
        
        if themes.isEmpty {
            themes = [ThemeModel(name: "Animals", emojis: "🐱🐶🐭🐹🐼🐻🦊🐰🐨🐯🦁", numbers: 3, color: "red"),
                      ThemeModel(name: "Vehicles", emojis: "🚗🚕🚙🚌🚑🚓🏎🚎", numbers: 4, color: "blue"),
                      ThemeModel(name: "Food", emojis: "🍎🍏🍋🍌🍉🍇🍒🍈🍆🥒🥑", numbers: 5, color: "green")
            ]
        }
    }
    
    func storeData() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultKey)
    }
    
    func loadData() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultKey) {
            if let decoded = try? JSONDecoder().decode([ThemeModel].self, from: jsonData) {
                themes = decoded
            }
        }
    }
    
    // Mark Intents
    
}
