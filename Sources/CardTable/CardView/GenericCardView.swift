//
//  GenericCardView.swift
//  
//
//  Created by Mike Muszynski on 8/24/20.
//

import SwiftUI
import CardDeck

struct GenericCardView: View {
    var cardDescription: String
    
    var body: some View {
        GeometryReader { g in
            Text(cardDescription)
                .font(.largeTitle)
                .position(CGPoint(x: g.size.width / 2, y: g.size.height / 2))
        }
    }
}

fileprivate struct GenericCard: Card {
    var description: String { return "Card" }
    var debugDescription: String { return "Card" }
}

struct GenericCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = GenericCard()
        
        let floats = [100, 200, 300, 400] as [CGFloat]
        ForEach(floats, id: \.self) { size in
            Group {
                HStack {
                    CardView(card: card)
                        .previewDisplayName("Front")
                    CardView(card: card, flipped: true)
                        .previewDisplayName("Back")
                }
            }
            .previewLayout(.fixed(width: 2.5 * size * 2, height: 3.5 * size))
        }
    }
}
