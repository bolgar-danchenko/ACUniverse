//
//  Character.swift
//  ACUniverseSwiftUI
//
//  Created by Konstantin Bolgar-Danchenko on 03.02.2023.
//

import SwiftUI

// Character model
struct Character: Identifiable {
    
    var id = UUID().uuidString
    
    var name: String
    var game: Game
    var description: String
    
    var imageString: String
    var image: Image {
        Image(imageString)
    }
}

// Game model
enum Game: String, CaseIterable {
    case ac2 = "Assassin's Creed II"
    case ac3 = "Assassin's Creed III"
    case ac4 = "Assassin's Creed: Black Flag"
    case ac5 = "Assassin's Creed: Unity"
}
