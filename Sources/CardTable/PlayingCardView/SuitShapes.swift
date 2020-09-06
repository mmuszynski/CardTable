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
    var svgImage: SVGImageView {
        var name = ""
        switch self {
        case .spade:
            name = "Spade"
        case .diamond:
            name = "Diamond"
        case .club:
            name = "Club"
        case .heart:
            name = "Heart"
        }
        
        let url = Bundle.module.url(forResource: name, withExtension: "svg")!
        let image = try! SVGImage(contentsOf: url)
        return SVGImageView(image: image)
    }
}

struct SuitShapes_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayingCard.Suit.diamond.svgImage
            PlayingCard.Suit.club.svgImage
            PlayingCard.Suit.spade.svgImage
            PlayingCard.Suit.heart.svgImage
            
            SVGImageView(image: try! SVGImage(contentsOf: Bundle.module.url(forResource: "CLUB-11-JACK", withExtension: "svg")!))
        }
    }
}
