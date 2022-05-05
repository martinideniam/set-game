//
//  SetGameModel.swift
//  set-game
//
//  Created by Vladislav Gorovenko on 04.05.2022.
//

import Foundation

struct SetGameModel {
    
    var cards: Array<Card>
    
    init(numbersGenerator: () -> [Array<Int>]) {
        cards = []
        for arrayOfInt in numbersGenerator() {
            cards.append(generateCard(arrayOfInt: arrayOfInt))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var symbol: Int
        var color: Int
        var number: Int
        var shading: Int
        var id: String
    }
    
    func generateCard(arrayOfInt: Array<Int>) -> Card  {
        Card(symbol: arrayOfInt[0],
             color: arrayOfInt[1],
             number: arrayOfInt[2],
             shading: arrayOfInt[3],
             id: UUID().uuidString)
    }
    
    // intent - functions
}
