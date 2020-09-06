//
//  CardColorScheme.swift
//  
//
//  Created by Mike Muszynski on 8/24/20.
//

import SwiftUI

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
