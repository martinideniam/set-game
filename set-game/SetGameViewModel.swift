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
    @Published var score: Int = 0
    
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
    
    func checkIfSet(selectedCards: Array<Card>) -> Bool {
        if selectedCards.count < 3 {
            return false
        }
        var counter = 0
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        let card3 = selectedCards[2]
        if (card1.shading == card2.shading) && (card1.shading == card3.shading) {
            counter += 1
        } else if (card1.shading != card2.shading) && (card1.shading != card3.shading) && (card2.shading != card3.shading) {
            counter += 1
        }
        if (card1.number == card2.number) && (card1.number == card3.number) {
            counter += 1
        } else if (card1.number != card2.number) && (card1.number != card3.number) && (card2.number != card3.number) {
            counter += 1
        }
        if (card1.color == card2.color) && (card1.color == card3.color) {
            counter += 1
        } else if (card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color) {
            counter += 1
        }
        if (card1.symbol == card2.symbol) && (card1.symbol == card3.symbol) {
            counter += 1
        } else if (card1.symbol != card2.symbol) && (card1.symbol != card3.symbol) && (card2.symbol != card3.symbol) {
            counter += 1
        }
        if counter == 4 {
            return true
        }
        return false
    }
    
    func dealWithSetCards(selectedCards: Array<Card>) {
        if checkIfSet(selectedCards: selectedCards) {
            score += 3
            for card in selectedCards {
                cardIsSet(card: card)
            }
        } else {
            score -= 1
        }
    }
    
    func resetScore() {
        score = 0
    }
    
    func cardIsSet(card: Card) {
        model.cardIsSet(card: card)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
}
