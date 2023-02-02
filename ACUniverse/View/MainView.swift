//
//  MainView.swift
//  ACUniverse
//
//  Created by Konstantin Bolgar-Danchenko on 03.02.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    // Animation for matched geometry effect
    var animation: Namespace.ID
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                
                // Title
                Text("Choose a Game")
                    .font(.custom(assassinFont, size: 40))
                    .foregroundColor(Color("main"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                    .padding(.horizontal, 25)
                
                // Game tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(Game.allCases, id: \.self) { game in
                            // Buttons with capsule overlay
                            GameView(game: game)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                // Character cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(viewModel.filteredCharacters) { character in
                            CharacterCardView(character: character)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 100)
                }
                .padding(.top, 30)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
        .overlay(
            ZStack {
                // Character details page
                if let character = viewModel.selectedCharacter,
                   viewModel.showSelectedCharacter {
                    CharacterDetailView(character: character, animation: animation)
                        .environmentObject(viewModel)
                    // Adding transitions
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
        // Updating characters whenever game changes
        .onChange(of: viewModel.game) { newValue in
            viewModel.filterCharactersByGame()
        }
    }
    
    @ViewBuilder
    func GameView(game: Game) -> some View {
        Button {
            // Updating selected game
            withAnimation {
                viewModel.game = game
            }
        } label: {
            Text(game.rawValue)
                .font(.custom(assassinFont, size: 23))
                .fontWeight(.semibold)
            
            // Changing color based on selected game
                .foregroundColor(viewModel.game == game ? Color("highlight") : Color("highlight").opacity(0.4))
                .padding(.bottom, 10)
                .overlay(
                    ZStack {
                        if viewModel.game == game {
                            Capsule()
                                .fill(Color("main").opacity(0.7))
                                .matchedGeometryEffect(id: "GAME", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }
    }
    
    @ViewBuilder
    func CharacterCardView(character: Character) -> some View {
        VStack(spacing: 10) {
            // Adding matched geometry effect
            ZStack {
                if viewModel.showSelectedCharacter {
                    character.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    character.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(character.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 1.5, height: getRect().width / 1.5)
            // Moving character image to top
            .offset(y: -80)
            .padding(.bottom, -80)
            
            Text(character.name)
                .font(.custom(assassinFont, size: 30))
                .foregroundColor(Color("main"))
                .padding(.top)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color("highlight").opacity(0.9)
                .cornerRadius(25)
                .shadow(color: Color("main"), radius: 5, x: 5, y: 5)
        )
        // Showing character details when tapped
        .onTapGesture {
            withAnimation(.easeInOut) {
                viewModel.selectedCharacter = character
                viewModel.showSelectedCharacter = true
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
