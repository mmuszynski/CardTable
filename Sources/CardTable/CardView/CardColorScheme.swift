//
//  CardColorScheme.swift
//  
//
//  Created by Mike Muszynski on 8/24/20.
//

import SwiftUI

public struct CardColorScheme {
    public var cardColor: Color
    public var cardBackColor: Color
    public var borderColor: Color
    public var accentColor: Color
    
    public static let redWhiteBlue = CardColorScheme(cardColor: .white,
                                              cardBackColor: Color.red.opacity(0.5),
                                              borderColor: Color.red.opacity(1),
                                              accentColor: Color(red: 1, green: 1, blue: 1))
}
