//
//  CardBackPattern.swift
//  
//
//  Created by Mike Muszynski on 8/24/20.
//

import SwiftUI
import CardDeck

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

struct Diagonal: Shape {
    func path(in rect: CGRect) -> Path {
        var line = Path()
        line.move(to: rect.origin)
        line.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        return line
    }
}

struct CardBackPattern_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: "JS" as PlayingCard, isFlipped: true)
            .previewLayout(.sizeThatFits)
    }
}
