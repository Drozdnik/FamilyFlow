import SwiftUI

struct RoomCardView: CardViewItemProtocol {
    let room: RoomItem

    var contentView: some View {
        Text("\(room.title)")
            .font(.headline)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
