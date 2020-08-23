import SwiftUI
import CardGames
import CardDeck

struct CardTableView<CardType: Card>: View {
    var hands: [CardGameSeat : Deck<CardType>]
    var body: some View {
        EmptyView()
    }
}

struct CardTable_Previews: PreviewProvider {
    static var previews: some View {
        CardTableView<PlayingCard>(hands: [.south : ["AS", "JS"]])
    }
}
