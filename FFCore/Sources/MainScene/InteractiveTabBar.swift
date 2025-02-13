import SwiftUI

struct InteractiveTabBar: View {
    @Binding var activeTab: TabItem
    @Namespace private var animation

    var body: some View {
        HStack {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tapButton(tab)
            }
        }
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.bottom, Constants.bottomPadding)
        .background(.background.shadow(.drop(
            color: .primary.opacity(Constants.shadowOpacity),
            radius: Constants.shadowRadius))
        )
    }

    func tapButton(_ tab: TabItem) -> some View {
        let isActive = activeTab == tab

        return VStack {
            Image(systemName: tab.imageName)
                .symbolVariant(.fill)
                .frame(
                    width: isActive ? Constants.activeIconSize : Constants.inactiveIconSize,
                    height: isActive ? Constants.activeIconSize : Constants.inactiveIconHeight
                )
                .background {
                    if isActive {
                        Circle()
                            .fill(.blue.gradient)
                            .matchedGeometryEffect(id: "ActiveTab", in: animation)
                    }
                }
                .frame(width: Constants.iconFrameWidth,
                       height: Constants.iconFrameHeight,
                       alignment: .bottom)
                .foregroundStyle(isActive ? .white : .primary)
                .padding(.bottom, Constants.iconBottomPadding)

            Text(tab.title)
                .font(.caption2)
                .foregroundStyle(isActive ? .blue : .gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            withAnimation(.snappy) {
                activeTab = tab
            }
        }
    }
}

private enum Constants {
    static let height: CGFloat = 50
    static let horizontalPadding: CGFloat = 15
    static let bottomPadding: CGFloat = 10

    static let activeIconSize: CGFloat = 50
    static let inactiveIconSize: CGFloat = 25
    static let inactiveIconHeight: CGFloat = 0
    static let iconFrameWidth: CGFloat = 10
    static let iconFrameHeight: CGFloat = 25
    static let iconBottomPadding: CGFloat = 10

    static let shadowOpacity: Double = 0.2
    static let shadowRadius: CGFloat = 0.5
}
