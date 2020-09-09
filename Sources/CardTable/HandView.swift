//
//  HandView.swift
//  
//
//  Created by Mike Muszynski on 8/23/20.
//

import SwiftUI
import CardDeck

public struct HandView<CardType: Card>: View {
    @Binding public var cards: Deck<CardType>
    
    @Binding var selection: Set<Int>
    @State var dragIndex: Int? = nil
    @GestureState var dragOffset: CGSize = .zero
    
    @State var fuckYouXcode: String = "x"
    
    public init(cards: Binding<Deck<CardType>>, selection: Binding<Set<Int>>) {
        self._cards = cards
        self._selection = selection
    }
    
    var perCardOffsetAmount: CGFloat {
        return 40
    }
    
    var cardsOffset: CGFloat {
        return self.dragOffset.width / perCardOffsetAmount
    }
    
    func proposedDropIndex(for offset: CGSize) -> Int? {
        guard let current = dragIndex else { return nil }
        let index = Int(offset.width / perCardOffsetAmount) + current
        
        fuckYouXcode = "\(current) \(index)"
        
        return index
    }
    
    var cardOffsets: [CGFloat] {
        let indices = self.cards.enumerated().map(\.offset)
        let initialOffset = CGFloat(self.cards.count / 2) * perCardOffsetAmount
        var output: [CGFloat]
        
        if let dragged = dragIndex, let proposedDrop = proposedDropIndex(for: dragOffset), dragged != proposedDrop {
            output = indices.map { index in
                
                if proposedDrop < dragged {
                    if (proposedDrop..<dragged).contains(index) {
                        return CGFloat(index + 1) * perCardOffsetAmount
                    }
                } else {
                    if (dragged+1...proposedDrop).contains(index) {
                        return CGFloat(index - 1) * perCardOffsetAmount
                    }
                }
                
                return CGFloat(index) * perCardOffsetAmount
            }
        } else {
            output = indices.map { CGFloat($0) * perCardOffsetAmount }
        }
        
        return output.map { $0 - initialOffset }
    }
    
    func angle(for offset: CGFloat) -> Angle {
        return Angle(degrees: Double(offset * 0.05))
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<cards.count) { index in
                CardView(card: cards[index])
                    //composite to avoid the shadow on every element
                    .compositingGroup()
                    //apply the shadow
                    .shadow(radius: 2)
                    //set the z index based on the order of the hand
                    //plus, if the card is being dragged, update the index there as well
                    .zIndex(Double(index) + Double(dragIndex == index ? cardsOffset : 0))
                    //offset the card based on where it is in the hand index
                    //offset the card further if it is the one being dragged
                    .rotationEffect(angle(for: dragIndex == index ? dragOffset.width : 0))
                    .offset(x: cardOffsets[index], y: 0)
                    .offset(dragIndex == index ? dragOffset : .zero)
                    .rotationEffect(angle(for: cardOffsets[index]), anchor: .bottom)
                    //the actual drag gesture
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                .updating($dragOffset, body: { (value, state, transaction) in
                                    dragIndex = index
                                    state = value.translation
                                })
                                .onEnded({ (gestureValue) in
                                    let proposedDropIndex = self.proposedDropIndex(for: gestureValue.translation)!
                                    var newIndex = proposedDropIndex
                    
                                    newIndex = newIndex < 0 ? 0 : newIndex
                                    let thisCard = cards.remove(at: dragIndex!)
                                    
                                    newIndex = newIndex >= cards.count ? cards.endIndex : newIndex
                                    cards.insert(thisCard, at: newIndex)
                                }))
                
            }
        }
        .frame(width: 250 + (self.cardOffsets.last ?? 100) - (self.cardOffsets.first ?? 100))
        .offset(x: 75)
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        let deck = Deck(PlayingCard.fullDeck[0..<10]).sorted(by: PlayingCard.defaultAscendingOrder)
        
        BindingProvider(deck) { binding in
            HandView(cards: binding, selection: .constant(Set()))
        }
    }
}

struct BindingProvider<StateT, Content: View>: View {
    
    @State private var state: StateT
    private var content: (_ binding: Binding<StateT>) -> Content
    
    init(_ initialState: StateT, @ViewBuilder content: @escaping (_ binding: Binding<StateT>) -> Content) {
        self.content = content
        self._state = State(initialValue: initialState)
    }
    
    var body: some View {
        self.content($state)
    }
}
