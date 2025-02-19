import SwiftUI

protocol CardViewItemProtocol {
    associatedtype Body: View

    var contentView: Body { get }
}

private enum Constants {
    static let spacing = 5.0
    static let cornerRadius = 10.0
    static let shadowRadius = 3.0
}

struct CardView<Item: CardViewItemProtocol>: View {

    let item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            item.contentView
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: Constants.shadowRadius)
    }
}
