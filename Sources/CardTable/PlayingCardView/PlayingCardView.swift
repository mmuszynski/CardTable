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
            ZStack {
                let cardNameplate = HStack {
                    VStack(spacing: 0) {
                        Text(card.rank.debugDescription)
                            .font(.largeTitle)
                        card.suit.svgImage
                            .frame(width: 25, height: 25)
                        Spacer()
                    }
                    Spacer()
                }.padding(5)
                
                cardNameplate
                cardNameplate
                    .rotationEffect(.degrees(180))
            }
            
            PlayingCardSuitPattern(suit: card.suit, count: card.rank.glyphCount)
                .padding(45)
            
            Rectangle()
                .stroke(Color.black)
                .padding(40)
            
        }.foregroundColor(card.suit.color)
    }
}

struct PlayingCard_Previews: PreviewProvider {
    static var previews: some View {
        let card: PlayingCard = "10C"
        
        Group {
            ForEach(PlayingCard.Rank.allCases[0..<10], id: \.self) { rank in
                HStack {
                    ForEach(PlayingCard.Suit.allCases, id: \.self) { suit in
                        let card = PlayingCard(rank: rank, suit: suit)
                        CardView(card: card)
                    }
                }
            }
            .previewDisplayName("Front")
            .previewLayout(.sizeThatFits)
        }
    }
}
