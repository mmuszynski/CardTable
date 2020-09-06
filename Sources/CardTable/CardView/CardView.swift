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
        .aspectRatio(CGSize(width: 2.5, height: 3.5), contentMode: .fit)
    }
}

private struct CommonElements: View {
    var colorScheme: CardColorScheme
    var flipped: Bool
    
    var body: some View {
        GeometryReader{ g in
            let cornerRadius = g.size.width * 0.05
            let padding = cornerRadius * 0.5
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(cornerRadius)
                if flipped {
                Rectangle()
                    .fill(colorScheme.borderColor)
                    .cornerRadius(cornerRadius)
                }
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(cornerRadius)
                    .padding(padding)
                Rectangle()
                    .fill(flipped ? colorScheme.cardBackColor : colorScheme.cardColor)
                    .cornerRadius(cornerRadius)
                    .padding(padding)
            }
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
