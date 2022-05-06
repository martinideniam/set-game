//
//  SetGameViewModel.swift
//  set-game
//
//  Created by Vladislav Gorovenko on 04.05.2022.
//

import Foundation

class SetGameViewModel: ObservableObject {
    typealias Card = SetGameModel.Card
    
    @Published var model: SetGameModel = createGame()
    
    func createNewGame() {
        model = SetGameViewModel.createGame()
    }
    
    private static func createGame() -> SetGameModel {
        SetGameModel(numbersGenerator: {
            var arrayOfNumbers = [Array<Int>]()
            for symbol in 0...2 {
                for color in 0...2 {
                    for number in 1...3 {
                        for shading in 0...2 {
                            arrayOfNumbers.append([symbol, color, number, shading])
                        }
                    }
                }
            }
            return arrayOfNumbers
        })
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
}
