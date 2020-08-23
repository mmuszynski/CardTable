//
//  PlayingCardSuitPattern.swift
//  
//
//  Created by Mike Muszynski on 8/22/20.
//

import SwiftUI
import CardDeck

struct PlayingCardSuitPattern: View {
    var suit: PlayingCard.Suit
    var count: Int
    
    fileprivate func rowOfOne(font: Font) -> HStack<Text> {
        return HStack {
            Text(suit.debugDescription)
                .font(font)
        }
    }
    
    fileprivate func rowOfTwo(font: Font) -> HStack<TupleView<(Text, Spacer, Text)>> {
        return HStack {
            Text(suit.debugDescription)
                .font(font)
            Spacer()
            Text(suit.debugDescription)
                .font(font)
        }
    }
    
    fileprivate func columnOfThree(font: Font) -> VStack<TupleView<(Text, Spacer, Text, Spacer, Text)>> {
        return VStack {
            Text(suit.debugDescription)
                .font(font)
            Spacer()
            Text(suit.debugDescription)
                .font(font)
            Spacer()
            Text(suit.debugDescription)
                .font(font)
        }
    }
    
    fileprivate func columnOfFour(font: Font) -> VStack<TupleView<(Text, Spacer, Text, Spacer, Text, Spacer, Text)>> {
        return VStack {
            Text(suit.debugDescription)
                .font(font)
            Spacer()
            Text(suit.debugDescription)
                .font(font)
            Spacer()
            Text(suit.debugDescription)
                .font(font)
            Spacer()
            Text(suit.debugDescription)
                .font(font)
        }
    }
    
    var body: some View {
        GeometryReader { g in
            let size = g.size.height > g.size.width ? g.size.width: g.size.height
            let fontSize = size * 0.35
            let font = Font.system(size: fontSize)
            
            Group {
                switch count {
                case 1, 2, 3:
                    VStack {
                        ForEach(0..<count) { i in
                            rowOfOne(font: font)
                            if i + 1 != count {
                                Spacer()
                            }
                        }
                    }
                case 5:
                    VStack {
                        rowOfTwo(font: font)
                        Spacer()
                        rowOfOne(font: font)
                        Spacer()
                        rowOfTwo(font: font)
                    }
                case 7:
                    HStack {
                        columnOfThree(font: font)
                        VStack {
                            Spacer()
                            Text(suit.debugDescription)
                                .font(font)
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        columnOfThree(font: font)
                    }
                case 4, 6, 8:
                    VStack {
                        ForEach(0..<(count / 2)) { i in
                            rowOfTwo(font: font)
                            
                            if i + 1 != count / 2 { Spacer() }
                        }
                    }
                case 9:
                    HStack {
                        columnOfFour(font: font)
                        VStack {
                            Spacer()
                            Text(suit.debugDescription)
                                .font(font)
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        columnOfFour(font: font)
                    }
                case 10:
                    HStack {
                        columnOfFour(font: font)
                        Spacer()
                        VStack {
                            Spacer()
                            Text(suit.debugDescription)
                                .font(font)
                            Spacer()
                            Text(suit.debugDescription)
                                .font(font)
                            Spacer()
                        }
                        Spacer()
                        columnOfFour(font: font)
                    }
                default:
                    Rectangle()
                }
            }
            .position(x: g.size.width / 2, y: g.size.height / 2)
        }
    }
}

struct PlayingCardSuitPattern_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(7..<10) { count in
            PlayingCardSuitPattern(suit: .club, count: count)
                .previewDisplayName("\(count)")
        }.previewLayout(.sizeThatFits)
    }
}
