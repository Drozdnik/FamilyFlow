import SwiftUI

public struct RootView: View {
    @State private var activeTab: TabItem = .tasks
    @Environment(\.diContainer) private var diContainer

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                NavigationView {
                    SlotsViewFactory
                        .makeSlotsView(for: .room(RoomsViewModel(networkingService: diContainer.networkService)))
                }.tint(.black)
                    .tag(TabItem.tasks)
                CalendarView(calendarViewModel: CalendarViewModel(tasksStorage: diContainer.tasksStorage))
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
