//
//  MainViewModel.swift
//  ACUniverseSwiftUI
//
//  Created by Konstantin Bolgar-Danchenko on 03.02.2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    // Pre-set characters
    @Published var characters: [Character] = [
        
        Character(name: "Ezio Auditore da Firenze", game: Game.ac2, description: "Ezio Auditore da Firenze was a Florentine nobleman during the Renaissance, and, unbeknownst to most historians and philosophers, a Master Assassin and the Mentor of the Italian Brotherhood of Assassins. He is also an ancestor of William and Desmond Miles, as well as Clay Kaczmarek.", imageString: "ezio"),
        
        Character(name: "Leonardo da Vinci", game: Game.ac2, description: "Leonardo di ser Piero da Vinci, more commonly Leonardo da Vinci or simply Leonardo, was an Italian anatomist, sculptor, cartographer, painter, botanist, engineer, architect, and mathematician of the Renaissance. He is widely regarded by scholars, engineers, and artists around the world to be one of the greatest minds in history.", imageString: "leonardo"),
        
        Character(name: "Haytham Kenway", game: Game.ac3, description: "Haytham E. Kenway was the first Grand Master of the Templar Order's Colonial Rite, reigning until his death, whereupon he was succeeded by Charles Lee.", imageString: "haytham"),
        
        Character(name: "George Washington", game: Game.ac3, description: "George Washington was the Commander-in-Chief of the Continental Army in the American Revolutionary War, and served as the first President of the United States", imageString: "washington"),
        
        Character(name: "Edward Kenway", game: Game.ac4, description: "Edward James Kenway was a Welsh-born British privateer-turned-pirate and a member of the West Indies and British Brotherhoods of Assassins.", imageString: "edward"),
        
        Character(name: "Mary Read", game: Game.ac4, description: "Mary Read was an English pirate and member of the West Indies Brotherhood of Assassins, trained by the Mentor Ah Tabai. She was also one of the founders of the Pirate Republic of Nassau.", imageString: "mary"),
        
        Character(name: "Edward Thatch", game: Game.ac4, description: "Edward Thatch, also known by the alias Blackbeard, was an infamous English pirate captain who sailed the West Indies and the eastern seaboard of the American colonies during the early 18th century, aboard the ship Queen Anne's Revenge, being one of the most respected crime lords of the time.", imageString: "thatch"),
        
        Character(name: "Arno Dorian", game: Game.ac5, description: "Arno Victor Dorian was a member of the French Brotherhood of Assassins and a Master Assassin during the French Revolution. He is also an ancestor of the modern Assassin Callum Lynch.", imageString: "arno"),
        
        Character(name: "Napoleon Bonaparte", game: Game.ac5, description: "Napoleon Bonaparte, born Napoleone di Buonaparte, and later Napoleon I, was a Corsican military and political leader who ruled first as the First Consul of France, then as Emperor of the French.", imageString: "napoleon")
    ]
    
    // Game selected by default
    @Published var game: Game = .ac2
    
    // To allow selection of a character
    @Published var selectedCharacter: Character?
    @Published var showSelectedCharacter: Bool = false
    
    // Characters filtered by game
    @Published var filteredCharacters: [Character] = []
    
    init() {
        filterCharactersByGame()
    }
    
    /// Method updates the array of filtered characters according to selected game
    func filterCharactersByGame() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.characters
                .lazy
                .filter { character in
                    return character.game == self.game
                }
            
            DispatchQueue.main.async {
                self.filteredCharacters = results.compactMap({ character in
                    return character
                })
            }
        }
    }
}


