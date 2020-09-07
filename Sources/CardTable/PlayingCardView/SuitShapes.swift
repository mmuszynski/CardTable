//
//  SuitShapes.swift
//  
//
//  Created by Mike Muszynski on 8/24/20.
//

import Foundation
import SwiftUI
import CardDeck
import SVGParser

extension PlayingCard.Suit {
    private static var spadeImage: SVGImageView {
        let url = Bundle.module.url(forResource: "Spade", withExtension: "svg")!
        let image = try! SVGImage(contentsOf: url)
        return SVGImageView(image: image)
    }
    
    private static var diamondImage: SVGImageView {
        let url = Bundle.module.url(forResource: "Diamond", withExtension: "svg")!
        let image = try! SVGImage(contentsOf: url)
        return SVGImageView(image: image)
    }
    
    private static var clubImage: SVGImageView {
        let url = Bundle.module.url(forResource: "Club", withExtension: "svg")!
        let image = try! SVGImage(contentsOf: url)
        return SVGImageView(image: image)
    }
    
    private static var heartImage: SVGImageView {
        let url = Bundle.module.url(forResource: "Heart", withExtension: "svg")!
        let image = try! SVGImage(contentsOf: url)
        return SVGImageView(image: image)
    }
    
    var svgImage: SVGImageView {
        switch self {
        case .spade:
            return PlayingCard.Suit.spadeImage
        case .diamond:
            return PlayingCard.Suit.diamondImage
        case .club:
            return PlayingCard.Suit.clubImage
        case .heart:
            return PlayingCard.Suit.heartImage
        }
    }
}

struct SuitShapes_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayingCard.Suit.diamond.svgImage
            PlayingCard.Suit.club.svgImage
            PlayingCard.Suit.spade.svgImage
            PlayingCard.Suit.heart.svgImage
        }
    }
}
