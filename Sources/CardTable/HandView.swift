//
//  HandView.swift
//  
//
//  Created by Mike Muszynski on 8/23/20.
//

import SwiftUI
import CardDeck

struct HandView<CardType: Card>: View {
    var cards: Deck<CardType>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        let deck = Deck(PlayingCard.fullDeck.shuffled()[0..<5])
        HandView(cards: deck)
    }
}
