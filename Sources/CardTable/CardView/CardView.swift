//
//  File.swift
//  
//
//  Created by Mike Muszynski on 8/22/20.
//

import Foundation
import SwiftUI
import CardDeck

public struct CardView<CardType: Card>: View {
    public init(card: CardType, isFlipped: Bool = false) {
        self.card = card
    }
    
    var card: CardType
    public var isFlipped: Bool = false
    public var colorScheme: CardColorScheme = .redWhiteBlue
    
    public var body: some View {
        ZStack {
            CommonElements(colorScheme: colorScheme, isFlipped: isFlipped)
            
            if isFlipped {
                CardBackPattern(colorScheme: colorScheme)
            } else {
                if card is PlayingCard {
                    PlayingCardView(card: card as! PlayingCard, isFlipped: isFlipped, colorScheme: colorScheme)
                } else {
                    GenericCardView(cardDescription: card.description)
                }
            }
        }
        .frame(width: 250, height: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

private struct CommonElements: View {
    var colorScheme: CardColorScheme
    var isFlipped: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(20)
            if isFlipped {
                Rectangle()
                    .fill(colorScheme.borderColor)
                    .cornerRadius(20)
            }
            Rectangle()
                .fill(Color.white)
                .cornerRadius(20)
                .padding(20)
            Rectangle()
                .fill(isFlipped ? colorScheme.cardBackColor : colorScheme.cardColor)
                .cornerRadius(20)
                .padding(20)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: "3S" as PlayingCard)
        }
    }
}
