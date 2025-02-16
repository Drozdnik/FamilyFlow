import SwiftUI

public struct RootView: View {
    @State private var activeTab: TabItem = .tasks
    @Environment(\.diContainer) private var diContainer

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                NavigationView {
                    TasksView(viewModel: RoomsViewModel(networkingService: diContainer.networkService))
                }.tint(.black)
                    .tag(TabItem.tasks)
                Text("В разработке")
                    .tag(TabItem.calendar)
                Text("В разработке")
                    .tag(TabItem.bag)
                Text("В разработке")
                    .tag(TabItem.profile)
            }
        }

        InteractiveTabBar(activeTab: $activeTab)
    }
}
