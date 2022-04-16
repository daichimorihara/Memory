//
//  ThemeView.swift
//  Memory
//
//  Created by Daichi Morihara on 2022/04/13.
//

import SwiftUI

struct ThemeView: View {
    @StateObject var vm = ThemeViewModel()
    @State private var editMode: EditMode = .inactive
    @State private var plusSheet = false
    @State private var editSheet = false
    @State private var themeToEdit = ThemeModel(name: "New", emojis: "", numbers: 2, color: "red")
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.themes) { theme in
                    NavigationLink(destination: CardGameView(vm: CardViewModel(theme: theme))) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.title)
                                //.foregroundColor(themeColor(theme))
                                .foregroundColor(editMode == .inactive ? themeColor(theme) : Color.black)
                            
                            
                            HStack {
                                if theme.numbers == theme.emojis.map{ String($0) }.count {
                                    Text("All of ")
                                } else {
                                    Text("\(theme.numbers) pairs from ")
                                }
                                Text(theme.emojis)
                            }
                            .lineLimit(1)
                        }
                        .gesture(editMode == .active ? tap(theme) : nil)
                    }
                }
                .onDelete { indexSet in
                    if vm.themes.count > 1 {
                        vm.themes.remove(atOffsets: indexSet)
                    }
                }
                .onMove { indexSet, newSet in
                    vm.themes.move(fromOffsets: indexSet, toOffset: newSet)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        plusSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $plusSheet) {
                NavigationView {
                    ThemeEdit(theme: $themeToEdit)
                        .navigationTitle("Theme Editor")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    backToThemeChooser()
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    if themeToEdit.emojis.map({ String($0) }).count > 1 {
                                        vm.themes.append(themeToEdit)
                                        backToThemeChooser()
                                    } else {
                                        // show alert that you should have at least two emojis
                                        showAlert = true
                                    }
                                }
                            }
                            
                            
                        }
                        .alert("Emojis can't be less than two,", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                }
            }
            .sheet(isPresented: $editSheet) {
                NavigationView {
                    ThemeEdit(theme: $themeToEdit)
                        .navigationTitle("Theme Editor")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    backToThemeChooser()
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    if themeToEdit.emojis.map({ String($0) }).count > 1 {
                                        vm.update(theme: themeToEdit)
                                        backToThemeChooser()
                                    } else {
                                        // show alert that you should have at least two emojis
                                        showAlert = true
                                    }
                                }
                            }
                        }
                        .alert("Emojis can't be less than two,", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    
    func themeColor(_ theme: ThemeModel) -> Color {
        switch theme.color {
        case "red": return .red
        case "blue": return .blue
        case "green": return .green
        default: return .red
        }
    }
    
    func backToThemeChooser() {
        themeToEdit = ThemeModel(name: "New", emojis: "", numbers: 2, color: "red")
        plusSheet = false
        editSheet = false
    }
    
    func tap(_ theme: ThemeModel) -> some Gesture {
        TapGesture()
            .onEnded {
                editSheet = true
                themeToEdit = theme
            }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
