import SwiftUI

public struct ContentView: View {
    @State private var activeTab: TabItem = .tasks
    @EnvironmentObject private var diContainer: DIContainer<TasksStorageImpl>

    public init () {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                TasksView(viewModel: diContainer.tasksViewModel)
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

struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
