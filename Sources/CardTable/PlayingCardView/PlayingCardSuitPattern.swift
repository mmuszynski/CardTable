//
//  PlayingCardSuitPattern.swift
//  
//
//  Created by Mike Muszynski on 8/22/20.
//

import SwiftUI
import CardDeck
import SVGParser

struct PlayingCardSuitPattern: View {
    var suit: PlayingCard.Suit
    var count: Int
    
    var suitSize: CGFloat = 40
    
    fileprivate func suitShape(isFlipped: Bool = false) -> some View {
        return suit.svgImage
            .rotationEffect(isFlipped ? Angle.radians(.pi) : .zero)
            .frame(width: suitSize, height: suitSize)
    }
    
    fileprivate var suitShape: some View {
        suit.svgImage
    }
    
    fileprivate var flippedSuitShape: some View {
        suit.svgImage
            .rotationEffect(.radians(.pi))
    }
    
    fileprivate func row(of count: Int, suitSize: CGFloat = 40, shouldFlip: Bool = false) -> some View {
        return HStack {
            ForEach(0..<count, id: \.self) { i in
                if shouldFlip {
                    flippedSuitShape
                        .frame(width: suitSize, height: suitSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                } else {
                    suitShape
                        .frame(width: suitSize, height: suitSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                if i != count-1 {
                    Spacer()
                }
            }
        }
    }
    
    fileprivate func column(of count: Int, shouldFlip: ((Int)->Bool)? = nil) -> some View {
        return VStack {
            ForEach(0..<count, id: \.self) { i in
                let shouldFlip = shouldFlip?(i) == true
                if shouldFlip {
                    flippedSuitShape
                } else {
                    suitShape
                }
                
                if i != count-1 {
                    Spacer()
                }
            }
        }
    }
    
    var body: some View {
            Group {
                switch count {
                case 1, 2, 3:
                    column(of: count, shouldFlip: { int in
                        count > 1 && int == count-1
                    })
                case 5:
                    GeometryReader { g in
                        VStack {
                            row(of: 2, suitSize: g.size.width / 4)
                            Spacer()
                            row(of: 1, suitSize: g.size.width / 4)
                            Spacer()
                            row(of: 2, suitSize: g.size.width / 4, shouldFlip: true)

                        }
                    }
                case 7:
                    VStack {
                        row(of: 2)
                        Spacer()
                        row(of: 1)
                        Spacer()
                        row(of: 2)
                        Spacer()
                        row(of: 2, shouldFlip: true)
                    }
                case 4, 6, 8:
                    VStack {
                        ForEach(0..<count/2) { i in
                            row(of: 2, shouldFlip: Double(i) >= Double(count) * 0.25)
                            
                            if i != count/2 - 1 {
                                Spacer()
                            }
                        }
                    }
                case 9:
                    VStack {
                        row(of: 2)
                        Spacer()
                        row(of: 1)
                        Spacer()
                        row(of: 2)
                        Spacer()
                        row(of: 2, shouldFlip: true)
                        Spacer()
                        row(of: 2, shouldFlip: true)
                    }
                case 10:
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            row(of: 2)
                            row(of: 1)
                            row(of: 2)
                        }
                        Spacer()
                        VStack(spacing: 0) {
                            row(of: 2, shouldFlip: true)
                            row(of: 1, shouldFlip: true)
                            row(of: 2, shouldFlip: true)
                        }
                    }
                default:
                    Rectangle()
                }
            }
    }
}

struct PlayingCardSuitPattern_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(5..<6) { count in
            PlayingCardSuitPattern(suit: .spade, count: count)
                .previewDisplayName("\(count)")
        }.previewLayout(.fixed(width: 200, height: 400))
    }
}
