//
//  ViewExtension.swift
//  ACUniverseSwiftUI
//
//  Created by Konstantin Bolgar-Danchenko on 03.02.2023.
//

import SwiftUI

// Getting rect equal to screen bounds to adjust size of some elements
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
