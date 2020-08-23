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
        .aspectRatio(2.5/3.5, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
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

struct GenericCardView: View {
    var cardDescription: String
    
    var body: some View {
        GeometryReader { g in
            Text(cardDescription)
                .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.6: g.size.height * 0.6))
                .position(CGPoint(x: g.size.width / 2, y: g.size.height / 2))
        }
    }
}

struct CardBackPattern: View {
    var colorScheme: CardColorScheme
    
    var body: some View {
        GeometryReader { g in
            let cornerRadius = g.size.width * 0.05
            let padding = cornerRadius * 0.5

            ForEach(-3..<4) { i in
                Diagonal()
                    .stroke(colorScheme.accentColor, lineWidth: padding)
                    .offset(x: g.size.height / 6 * CGFloat(i), y: 0)
                Diagonal()
                    .transform(.init(scaleX: -1, y: 1))
                    .transform(.init(translationX: g.size.width, y: 0))
                    .stroke(colorScheme.accentColor, lineWidth: padding)
                    .offset(x: g.size.height / 6 * CGFloat(i), y: 0)
            }.mask(Rectangle()
                    .cornerRadius(cornerRadius)
                    .padding(padding))
        }
    }
}

struct CardColorScheme {
    var cardColor: Color
    var cardBackColor: Color
    var borderColor: Color
    var accentColor: Color
    
    static let redWhiteBlue = CardColorScheme(cardColor: .white,
                                              cardBackColor: Color.red.opacity(0.5),
                                              borderColor: Color.red.opacity(1),
                                              accentColor: Color(red: 1, green: 1, blue: 1))
}

struct Diagonal: Shape {
    func path(in rect: CGRect) -> Path {
        var line = Path()
        line.move(to: rect.origin)
        line.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        return line
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card: PlayingCard = "JS"
        
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
