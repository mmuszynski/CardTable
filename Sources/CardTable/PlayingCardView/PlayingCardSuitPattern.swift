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
    
    fileprivate func suitShape(in geometry: GeometryProxy, flipped: Bool = false) -> some View {
        return suit.svgImage
            .rotationEffect(flipped ? Angle.radians(.pi) : .zero)
            .frame(width: geometry.size.width / 3,
                   height: geometry.size.width / 3)
    }
    
    fileprivate func row(of count: Int, in g: GeometryProxy, shouldFlip: Bool = false) -> some View {
        return HStack {
            ForEach(0..<count, id: \.self) { i in
                suitShape(in: g)
                    .rotationEffect(shouldFlip ? Angle.radians(.pi) : .zero)
                
                if i != count-1 {
                    Spacer()
                }
            }
        }
    }
    
    fileprivate func column(of count: Int, in g: GeometryProxy, shouldFlip: ((Int)->Bool)? = nil) -> some View {
        return VStack {
            ForEach(0..<count, id: \.self) { i in
                let shouldFlip = shouldFlip?(i) == true
                suitShape(in: g, flipped: shouldFlip)
                
                if i != count-1 {
                    Spacer()
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { g in
            Group {
                switch count {
                case 1, 2, 3:
                    column(of: count, in: g, shouldFlip: { int in
                        count > 1 && int == count-1
                    })
                case 5:
                    VStack {
                        row(of: 2, in: g)
                        Spacer()
                        row(of: 1, in: g)
                        Spacer()
                        row(of: 2, in: g, shouldFlip: true)
                    }
                case 7:
                    VStack {
                        row(of: 2, in: g)
                        Spacer()
                            .frame(height: g.size.height / 20)
                        row(of: 1, in: g)
                        Spacer()
                            .frame(height: g.size.height / 20)
                        row(of: 2, in: g)
                        Spacer()
                        row(of: 2, in: g, shouldFlip: true)
                    }
                case 4, 6, 8:
                    VStack {
                        ForEach(0..<count/2) { i in
                            row(of: 2, in: g, shouldFlip: Double(i) >= Double(count) * 0.25)
                            
                            if i != count/2 - 1 {
                                Spacer()
                            }
                        }
                    }
                case 9:
                    VStack {
                        row(of: 2, in: g)
                        Spacer()
                            .frame(height: g.size.height / 50)
                        row(of: 1, in: g)
                        Spacer()
                            .frame(height: g.size.height / 50)
                        row(of: 2, in: g)
                        Spacer()
                        row(of: 2, in: g, shouldFlip: true)
                        Spacer()
                        row(of: 2, in: g, shouldFlip: true)
                    }
                case 10:
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            row(of: 2, in: g)
                            row(of: 1, in: g)
                            row(of: 2, in: g)
                        }
                        Spacer()
                        VStack(spacing: 0) {
                            row(of: 2, in: g, shouldFlip: true)
                            row(of: 1, in: g, shouldFlip: true)
                            row(of: 2, in: g, shouldFlip: true)
                        }
                    }
                default:
                    Rectangle()
                }
            }
            .position(x: g.size.width / 2, y: g.size.height / 2)
        }.padding()
    }
}

struct PlayingCardSuitPattern_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(1..<11) { count in
            PlayingCardSuitPattern(suit: .spade, count: count)
                .previewDisplayName("\(count)")
        }.previewLayout(.fixed(width: 200, height: 400))
    }
}
