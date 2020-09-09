//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 9/9/20.
//

import SwiftUI
import CardDeck

struct VerticalCardStack<CardType: Card>: View {
    public var cards: Deck<CardType>
    
    var body: some View {
        ZStack {
            ForEach(0..<cards.count) { index in
                let card = cards[index]
                
                CardView(card: card)
                    .compositingGroup()
                    .shadow(radius: 2)
                    .offset(x: 0, y: CGFloat(index) * 100)
            }
        }
    }
}

struct VerticalCardStack_Previews: PreviewProvider {
    static var previews: some View {
        VerticalCardStack(cards: Deck(PlayingCard.fullDeck[0..<5]))
            .previewLayout(.sizeThatFits)
    }
}
