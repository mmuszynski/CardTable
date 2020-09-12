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
    
    var isFlipped: Bool
    var colorScheme: CardColorScheme
    
    var body: some View {
        GeometryReader { g in
            HStack {
                let cardNameplate = HStack {
                    VStack(spacing: 0) {
                        Text(card.rank.debugDescription)
                            .font(.largeTitle)
                        card.suit.svgImage
                            .frame(width: g.size.width * 0.1, height: g.size.width * 0.1)
                        Spacer()
                    }
                }
                
                cardNameplate
                    .padding([.leading, .trailing], g.size.width * 0.015)
                    .padding([.top], g.size.height * 0.01)

                PlayingCardSuitPattern(suit: card.suit, count: card.rank.glyphCount)
                    .padding()
                    .border(Color.black, width: g.size.width * 0.005)
                    .padding([.top, .bottom], 40)
                
                cardNameplate
                    .rotationEffect(.degrees(180))
                    .padding([.leading, .trailing], g.size.width * 0.015)
                    .padding([.top], g.size.height * 0.01)
                
            }.foregroundColor(card.suit.color)
        }
    }
}

struct PlayingCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PlayingCard.Rank.allCases[4..<5], id: \.self) { rank in
                HStack {
                    ForEach(PlayingCard.Suit.allCases, id: \.self) { suit in
                        let card = PlayingCard(rank: rank, suit: suit)
                        CardView(card: card)
                    }
                }
            }
            .previewDisplayName("Front")
        }
    }
}
