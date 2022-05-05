//
//  ContentView.swift
//  set-game
//
//  Created by Vladislav Gorovenko on 04.05.2022.
//

import SwiftUI

struct SetGameView: View {
    var viewModel = SetGameViewModel()
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .padding(5)
                    }
                }
            }
                .padding(5)
            Footer()
                .padding()
        }
    }
}

struct CardView: View {
    var card: SetGameModel.Card
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
            Group {
                returnShapeView(for: card)
            }
            .padding(15)
        }
        .aspectRatio(CardConstants.aspectRatio,
                     contentMode: .fit)
    }
    
    @ViewBuilder
    func returnShapeView(for card: SetGameModel.Card) -> some View {
        VStack {
            ForEach(0..<card.number) { _ in
                switch card.symbol {
                    case 0:
                        ZStack {
                            Ellipse()
                            .stroke(lineWidth: CGFloat(card.shading == 1 ? CardConstants.lineWidth : 0))
                            .colored(color: card.color)
                            Ellipse()
                            .colored(color: card.color)
                            .shaded(shading: card.shading)
                        }
                    case 1:
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: CGFloat(card.shading == 1 ? CardConstants.lineWidth : 0))
                            .colored(color: card.color)
                            Rectangle()
                            .colored(color: card.color)
                            .shaded(shading: card.shading)
                        }
                    default:
                        ZStack {
                            Diamond()
                            .stroke(lineWidth: CGFloat(card.shading == 1 ? CardConstants.lineWidth : 0))
                            .colored(color: card.color)
                            Diamond()
                            .colored(color: card.color)
                            .shaded(shading: card.shading)
                        }
                }
            }
        }
    }
    
    struct CardConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: Int = 2
        static let aspectRatio: CGFloat = 2.6/3
    }
}

struct Footer: View {
    
    var body: some View {
        HStack {
            newGameButton
            Spacer()
            addNewCards
        }
    }
    
    var newGameButton: some View {
        Button("New Game") {
            print("hell")
        }
    }
    
    var addNewCards: some View {
        Button("Deal 3 More Cards") {
            //
        }
    }
}

struct Colored: ViewModifier {
    var color: Int
    func body(content: Content) -> some View {
        switch color {
        case 0:
            content
                .foregroundColor(.red)
        case 1:
            content
                .foregroundColor(.green)
        default:
            content
                .foregroundColor(.purple)
        }
    }
}

struct Shaded: ViewModifier {
    var shading: Int
    func body(content: Content) -> some View {
        switch shading {
        case 0:
            content
        case 1:
            content
                .opacity(0)
        default:
            content
                .opacity(0.1)
        }
        
    }
}

extension View {
    func colored(color: Int) -> some View {
        self.modifier(Colored(color: color))
    }
    func shaded(shading: Int) -> some View {
        self.modifier(Shaded(shading: shading))
    }
}





struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
