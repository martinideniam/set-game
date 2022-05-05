//
//  set_gameApp.swift
//  set-game
//
//  Created by Vladislav Gorovenko on 04.05.2022.
//

import SwiftUI

@main
struct set_gameApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = SetGameViewModel()
            SetGameView(viewModel: viewModel)
        }
    }
}
