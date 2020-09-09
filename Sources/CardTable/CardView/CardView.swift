//
//  File.swift
//  
//
//  Created by Mike Muszynski on 8/22/20.
//

import Foundation
import SwiftUI
import CardDeck

struct CardView<CardType: Card>: View {
    var card: CardType
    var flipped: Bool = false
    
    var colorScheme: CardColorScheme = .redWhiteBlue
    
    var body: some View {
        ZStack {
            CommonElements(colorScheme: colorScheme, flipped: flipped)
            
            if flipped {
                CardBackPattern(colorScheme: colorScheme)
            } else {
                if card is PlayingCard {
                    PlayingCardView(card: card as! PlayingCard, flipped: flipped, colorScheme: colorScheme)
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
    var flipped: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(20)
            if flipped {
                Rectangle()
                    .fill(colorScheme.borderColor)
                    .cornerRadius(20)
            }
            Rectangle()
                .fill(Color.white)
                .cornerRadius(20)
                .padding(20)
            Rectangle()
                .fill(flipped ? colorScheme.cardBackColor : colorScheme.cardColor)
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
