//
//  ContentView.swift
//  ACUniverse
//
//  Created by Konstantin Bolgar-Danchenko on 03.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace var animation
    
    var body: some View {
        MainView(animation: animation)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
