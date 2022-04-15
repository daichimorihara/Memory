//
//  ThemeEdit.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/13.
//

import SwiftUI

struct ThemeEdit: View {
    @Binding var theme: ThemeModel
    
    var body: some View {
        Form {
            nameSection
            removeEmojisSection
            addEmojisSection
            cardCountSection
            colorSection
        }
    }
    
    var nameSection: some View {
        Section {
            TextField("NAME", text: $theme.name)
        } header: {
            Text("THEME NAME")
        }
    }
    
    var removeEmojisSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 20))]) {
                let emojis = theme.emojis.map{ String($0) }
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            if emojis.count > 2 {
                                if emojis.count == theme.numbers {
                                    theme.numbers -= 1
                                    theme.emojis.removeAll(where: { String($0) == emoji })
                                } else {
                                    theme.emojis.removeAll(where: { String($0) == emoji })
                                }
                            }
                        }
                }
            }
        } header: {
            Text("EMOJIS (Tap emoji to remove from list)")
        }
    }
    
    @State private var emojisToAdd: String = ""
    @State private var emojisSet = Set<String>()
    
    var addEmojisSection: some View {
        Section {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    theme.emojis = theme.emojis + emojis
                        .filter{ $0.isEmoji }
                        
                    
                    // remove duplicate characters
                    emojisSet = Set(theme.emojis.map({ String($0) }))
                    theme.emojis = Array(emojisSet).joined()
                }
                
        } header: {
            Text("ADD EMOJIS")
        }
    }
    
    func addEmojis(emojis: String) {
        theme.emojis = theme.emojis + emojis
            .filter{ $0.isEmoji }
    }
    
    var cardCountSection: some View {
        Section {
            let emojiCount = theme.emojis.map{ String($0) }.count
            Stepper(value: $theme.numbers, in: emojiCount > 1 ? 2...emojiCount : 2...2, step: 1) {
                Text("\(theme.numbers) Pairs")
            }
        } header: {
            Text("CARD COUNT")
        }

    }
    
    var colorSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                let shape = RoundedRectangle(cornerRadius: 3)
                ForEach(colors, id: \.self) { color in
                    ZStack {
                        shape.foregroundColor(makeColor(color))
                        shape.stroke().foregroundColor(.gray)
                        
                        if color == theme.color {
                            Image(systemName: "checkmark.circle")
                                .scaleEffect(1.5)
                                .foregroundColor(.white)
                        }
                    }
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        theme.color = color
                    }
                }
            }
        } header: {
            Text("COLOR")
        }

    }
    
    var colors = ["red", "blue", "green"]
    
    func makeColor(_ color: String) -> Color {
        switch color {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        default: return .red
        }
    }
}


// when save put emojisToAdd into theme.emojis
// clear emojisToAdd when saving
