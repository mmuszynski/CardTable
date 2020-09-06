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
                let fontSize = size * 0.18
                let font = Font.system(size: fontSize)
                
                ZStack {
                    VStack(spacing: 0) {
                        Text(card.rank.debugDescription)
                            .font(font)
                        card.suit.svgImage
                            .frame(width: size / 9, height: size / 9)
                        Spacer()
                    }
                    
                    VStack(spacing: 0) {
                        Text(card.rank.debugDescription)
                            .font(font)
                        card.suit.svgImage
                            .frame(width: size / 9, height: size / 9)
                        Spacer()
                    }
                    .padding(g.size.width * 0.025)
                    .rotationEffect(Angle(degrees: 180), anchor: UnitPoint.topLeading)
                    .offset(x: g.size.width, y: g.size.height)
                }
            }
            
            GeometryReader { g in
                PlayingCardSuitPattern(suit: card.suit, count: card.rank.glyphCount)
                    .border(Color.black)
                    .padding([.top, .bottom], g.size.height * 0.08)
                    .padding([.leading, .trailing], g.size.width * 0.22)
            }
        }.foregroundColor(card.suit.color)
    }
}

struct PlayingCard_Previews: PreviewProvider {
    static var previews: some View {
        let card: PlayingCard = "10C"
        
        Group {
            ForEach(PlayingCard.Rank.allCases[8..<10], id: \.self) { rank in
                HStack {
                    ForEach(PlayingCard.Suit.allCases, id: \.self) { suit in
                        let card = PlayingCard(rank: rank, suit: suit)
                        CardView(card: card)
                    }
                }
            }
            .previewDisplayName("Front")
            .previewLayout(.fixed(width: 2.5 * 4 * 205, height: 3.5 * 200))
        }
    }
}
