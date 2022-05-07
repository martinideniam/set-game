//
//  ContentView.swift
//  set-game
//
//  Created by Vladislav Gorovenko on 04.05.2022.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    typealias Card = SetGameModel.Card
    @State var howManyCards: Int = 12
    @State var selected = Array<Card>()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))]) {
                    ForEach(viewModel.cards[0..<howManyCards], id: \.id) { card in
                        if !card.set {
                            CardView(card: card)
                                .padding(5)
                                .setOrNot(set: viewModel.checkIfSet(selectedCards: selected), selectedContains: selected.contains(where: {
                                    $0.id == card.id}), selected: selected)
                                .selected(selected: selected.contains(where: {
                                    $0.id == card.id
                                }))
                                .onTapGesture { tapCardFunction(card: card) }
                        }
                    }
                }
            }
                .padding(5)
            scoreView
            HStack {
                newGameButton
                Spacer()
                addNewCards
            }
                .padding()
        }
    }
    
    func tapCardFunction(card: Card) {
        if selected.count >= 3 {
            viewModel.dealWithSetCards(selectedCards: selected)
            selected = []
            selected.append(card)
        } else {
            if let selectedCardIndex = selected.firstIndex(where: {$0.id == card.id}) {
                selected.remove(at: selectedCardIndex)
            } else {
                selected.append(card)
            }
        }
    }
    
    var scoreView: some View {
        Text("Ur score: \(viewModel.score) points")
    }
    
    var newGameButton: some View {
        Button("New Game") {
            viewModel.createNewGame()
            selected = []
            howManyCards = 12
            viewModel.resetScore()
        }
    }
    
    var addNewCards: some View {
        Button("Deal 3 More Cards") {
            howManyCards += 3
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
            ForEach(0..<card.number, id: \.self) { _ in
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

struct SetOrNot: ViewModifier {
    var set: Bool
    var selectedContains: Bool
    var selected: Array<SetGameModel.Card>
    func body(content: Content) -> some View {
        if selected.count == 3 && selectedContains == true {
            if set {
                content
                    .background(.green.opacity(0.1))
            } else {
                content
                    .background(.red.opacity(0.1))
            }
        } else {
            content
        }
    }
}

struct Selected: ViewModifier {
    var selected: Bool
    func body(content: Content) -> some View {
        if selected {
            content
                .shadow(color: .black, radius: 1, x:1, y: 1)
        } else {
            content
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
    func selected(selected: Bool) -> some View {
        self.modifier(Selected(selected: selected))
    }
    func setOrNot(set: Bool, selectedContains: Bool, selected: Array<SetGameModel.Card>) -> some View {
        self.modifier(SetOrNot(set: set, selectedContains: selectedContains, selected: selected))
    }
}





struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetGameViewModel()
        SetGameView(viewModel: viewModel)
    }
}
