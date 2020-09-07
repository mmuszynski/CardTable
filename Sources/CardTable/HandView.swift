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
    
    public init(cards: Binding<Deck<CardType>>, selection: Binding<Set<Int>>) {
        self._cards = cards
        self._selection = selection
    }
    
    var perCardOffsetAmount: Double {
        let angle = Double(cards.count) * 2
        return angle / Double(cards.count)
    }
    
    func fanAmount(_ index: Int) -> Double {
        let mid = Double(self.cards.count) / 2 - 0.5
        return (Double(index) - mid) * perCardOffsetAmount
    }
    
    func fanSpread(_ index: Int) -> CGSize {
        let angle = CGFloat(fanAmount(index))
        return CGSize(width: CGFloat(index - cards.count / 2) * CGFloat(cards.count), height: 0)
    }
    
    func index(from offset: CGFloat) -> Double {
        let count = Double(cards.count)
        return count * (Double(offset) + 0.5)
    }
    
    func reorderOffset(for offsetAmount: CGFloat) -> Int {
        let i = index(from: offsetAmount)
        return Int(i)
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<cards.count) { index in
                CardView(card: cards[index])
                    .zIndex(Double(dragIndex == index ? index + reorderOffset(for: dragOffset.width) : index))
                    .compositingGroup()
                    .shadow(radius: 5)
                    .offset(x: 0, y: selection.contains(index) ? -40 : 0)
                    //.rotationEffect(Angle(degrees: fanAmount(index)), anchor: .bottom)
                    .offset(fanSpread(index))
                    .offset(dragIndex == index ? dragOffset : .zero)
                    .shadow(color: selection.contains(index) ? .yellow : .clear, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .updating($dragOffset, body: { (value, state, transaction) in
                            dragIndex = index
                            state = value.translation
                            }).onEnded({ (gesture) in
                                withAnimation {
                                    dragIndex = nil
                                }
                            })
                )
            }
        }
    }
}

struct HandView_Previews: PreviewProvider {
    static var previews: some View {
        let deck = Deck(PlayingCard.fullDeck[0..<26]).sorted(by: PlayingCard.defaultAscendingOrder)
        
        BindingProvider(deck) { binding in
            HandView(cards: binding, selection: .constant(Set()))
                .scaledToFit()
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
