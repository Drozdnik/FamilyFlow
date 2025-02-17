import SwiftUI

private enum Constants: Double {
    case bodySpacing = 20.0
    case headerViewSpacing = 5.0
    case padding = 10.0
    case buttonSize = 24.0
}

enum LayoutType {
    case task(TasksViewModel)
    case room(RoomsViewModel)

    var viewModel: any TasksBaseVM {
        switch self {
        case let .task(viewModel):
            return viewModel
        case let .room(viewModel):
            return viewModel
        }
    }
}

struct TasksView<ViewModel: TasksBaseVM>: View {
    @State private var selectedProgressIndex: Int = 0
    private let layoutType: LayoutType

    private var selectedProgress: TaskProgress {
        TaskProgress.value(for: selectedProgressIndex)
    }
    private var progressDescription: String {
        TaskProgress.allCases.description
    }
    private var selectedProgressBinding: Binding<Int> {
        Binding {
            selectedProgressIndex
        } set: { newIndex in
            selectedProgressIndex = newIndex
            if case let.task(viewModel) = layoutType {
                viewModel.updateProgress(TaskProgress.value(for: newIndex))
            }
        }
    }

    init(layoutType: LayoutType, selectedProgressIndex: Int = 0) {
        self.layoutType = layoutType
        self.selectedProgressIndex = selectedProgressIndex
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.bodySpacing.rawValue) {
            headerView
                .animation(.easeInOut, value: selectedProgressIndex)

            taskListView
        }
        .navigationTitle(layoutType.viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: layoutType.viewModel.createItem) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    @ViewBuilder
    private var headerView: some View {
        switch layoutType {
        case let .task(viewModel):
            VStack(alignment: .leading, spacing: Constants.headerViewSpacing.rawValue) {
                Text("ID: \(viewModel.id)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("\(TaskProgress.value(for: selectedProgressIndex).description)")
                    .font(.headline)
                    .transition(.slide)
            }
            .padding(.leading, Constants.padding.rawValue)
        case .room:
            EmptyView()
        }
    }

    @ViewBuilder
    private var taskListView: some View {
        switch layoutType {
        case .task:
            TabView(selection: selectedProgressBinding) {
                ForEach(TaskProgress.allCases.indices, id: \.self) { _ in
                    scrollView
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        case .room:
            scrollView
        }
    }

    private var scrollView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Constants.padding.rawValue) {
                ForEach(layoutType.viewModel.items.compactMap({ $0 as? ViewModel.Item })) { item in
                    NavigationLink {
                        destinationView(for: item)
                    } label: {
                        TasksCardView(item: item)
                            .frame(maxWidth: .infinity)
                            .padding(.top, Constants.headerViewSpacing.rawValue)
                    }
                }
            }
            .padding([.leading, .trailing], Constants.padding.rawValue)
        }
    }

    @ViewBuilder
    private func destinationView(for item: Any) -> some View {
        switch item {
        case let task as TaskItem:
            EmptyView() // тут должен быть экран редактирования, а мб даже никак не среагировать
        case let room as Room:
            TasksView<TasksViewModel>(layoutType: .task(TasksViewModel(currentRoom: room)))
        default:
            fatalError("wrong type of item")
        }
    }
}
