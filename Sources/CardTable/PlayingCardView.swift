//
//  PlayingCardView.swift
//  CardTable
//
//  Created by Mike Muszynski on 8/22/20.
//

import SwiftUI
import CardDeck

fileprivate extension PlayingCard.Suit {
    var color: Color {
        switch self {
        case .diamond, .heart:
            return .red
        default:
            return .black
        }
    }
}

fileprivate extension PlayingCard.Rank {
    var glyphCount: Int {
        switch self {
        case .ace:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        default:
            return 0
        }
    }
}

struct PlayingCardView: View {
    var card: PlayingCard
    
    var flipped: Bool
    var colorScheme: CardColorScheme
    
    var body: some View {
        ZStack {
            GeometryReader { g in
                let size = g.size.height > g.size.width ? g.size.width: g.size.height
                let fontSize = size * 0.2
                let spacing = -fontSize * 0.2
                let font = Font.system(size: fontSize)
                let smallFont = Font.system(size: fontSize / 1.25)
                
                ZStack {
                    VStack(spacing: spacing) {
                        Group {
                            Text(card.rank.debugDescription)
                                .font(font)
                            Text(card.suit.debugDescription)
                                .font(smallFont)
                        }
                    }
                    .padding(g.size.width * 0.025)
                    
                    VStack(spacing: spacing) {
                        Group {
                            Text(card.rank.debugDescription)
                                .font(font)
                            Text(card.suit.debugDescription)
                                .font(smallFont)
                        }
                    }
                    .padding(g.size.width * 0.025)
                    .rotationEffect(Angle(degrees: 180), anchor: UnitPoint.topLeading)
                    .offset(x: g.size.width, y: g.size.height)
                }
            }

            GeometryReader { g in
                PlayingCardSuitPattern(suit: card.suit, count: card.rank.glyphCount)
                    .padding([.top, .bottom], g.size.height * 0.1)
                    .padding([.leading, .trailing], g.size.width * 0.2)
            }
        }.foregroundColor(card.suit.color)
    }
}

struct PlayingCard_Previews: PreviewProvider {
    static var previews: some View {
        let card: PlayingCard = "10C"
        
        Group {
            ForEach(PlayingCard.Rank.allCases, id: \.self) { rank in
            HStack {
                ForEach(PlayingCard.Suit.allCases, id: \.self) { suit in
                    let card = PlayingCard(rank: rank, suit: suit)
                    CardView(card: card)
                }
            }
            }
            .previewDisplayName("Front")
            .previewLayout(.fixed(width: 2.5 * 4 * 205, height: 3.5 * 200))
            
            CardView(card: card, flipped: true)
                .previewDisplayName("Back")
            
            //            ForEach(0..<PlayingCard.fullDeck.count) { index in
            //                CardView(card: PlayingCard.fullDeck[index])
            //                    .previewDisplayName(PlayingCard.fullDeck[index].description)
            //            }
        }
    }
}
