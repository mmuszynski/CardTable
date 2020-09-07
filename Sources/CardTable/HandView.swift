//
//  HandView.swift
//  
//
//  Created by Mike Muszynski on 8/23/20.
//

import SwiftUI
import CardDeck

public struct HandView<CardType: Card>: View {
    public var cards: Deck<CardType>
    @Binding var selection: Set<Int>
    
    public init(cards: Deck<CardType>, selection: Binding<Set<Int>>) {
        self.cards = cards
        self._selection = selection
    }
    
    func fanAmount(_ index: Int) -> Double {
        let mid = Double(self.cards.count) / 2 - 0.5
        let angle = 5.0
        return angle * (Double(index) - mid)
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<cards.count) { index in
                CardView(card: cards[index])
                    .compositingGroup()
                    .shadow(radius: 5)
                    .offset(x: 0, y: selection.contains(index) ? -40 : 0)

                    .rotationEffect(Angle(degrees: fanAmount(index)), anchor: .bottom)
                    .offset(x: CGFloat(index - cards.count / 2) * 15, y: 0)
                    .shadow(color: selection.contains(index) ? .yellow : .clear, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        withAnimation {
                            if selection.contains(index) {
                                selection.remove(index)
                            } else {
                                selection.insert(index)
                            }
                        }
                    })
            }
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        let deck = Deck(PlayingCard.fullDeck[0..<13]).sorted(by: PlayingCard.defaultAscendingOrder)
        
        BindingProvider(Set<Int>()) { selection in
            HandView(cards: deck, selection: selection)
                .scaledToFit()
        }
    }
}

struct BindingProvider<StateT, Content: View>: View {
    
    @State private var state: StateT
    private var content: (_ binding: Binding<StateT>) -> Content
    
    init(_ initialState: StateT, @ViewBuilder content: @escaping (_ binding: Binding<StateT>) -> Content) {
        self.content = content
        self._state = State(initialValue: initialState)
    }
    
    var body: some View {
        self.content($state)
    }
}
