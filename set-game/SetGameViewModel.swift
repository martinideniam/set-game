//
//  SetGameViewModel.swift
//  set-game
//
//  Created by Vladislav Gorovenko on 04.05.2022.
//

import Foundation

class SetGameViewModel {
    
    var model: SetGameModel
    
    init() {
        self.model = SetGameModel(numbersGenerator: {
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
    
    var cards: Array<SetGameModel.Card> {
        return model.cards
    }
}
