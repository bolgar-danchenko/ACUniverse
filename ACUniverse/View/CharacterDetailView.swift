//
//  CharacterDetailView.swift
//  ACUniverse
//
//  Created by Konstantin Bolgar-Danchenko on 03.02.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    // Character chosen on the MainView
    var character: Character
    
    // Animation for matched geometry effect
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            VStack {
                // Back button
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showSelectedCharacter = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color("highlight"))
                    }
                    Spacer()
                }
                .padding()
                
                // Character image appearing with matched geometry effect
                character.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(character.id)IMAGE", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2)
            
            // Character details
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(character.name)
                        .font(.custom(assassinFont, size: 30))
                        .foregroundColor(Color("main"))
                    
                    Text(character.game.rawValue)
                        .font(.custom(assassinFont, size: 23))
                        .foregroundColor(Color("highlight").opacity(0.7))
                    
                    Text("About")
                        .font(.custom(assassinFont, size: 25))
                        .foregroundColor(Color("main"))
                        .padding(.top)
                    
                    Text(character.description)
                        .font(.custom(assassinFont, size: 20))
                        .foregroundColor(Color("highlight").opacity(0.6))
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .cornerRadius(25)
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("background").ignoresSafeArea())
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
