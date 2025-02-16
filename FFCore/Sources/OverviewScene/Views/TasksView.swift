import SwiftUI

private enum Constants: Double {
    case bodySpacing = 20.0
    case headerViewSpacing = 5.0
    case padding = 10.0
    case buttonSize = 24.0
}

struct TasksView<ViewModel: TasksBaseVM>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var selectedProgressIndex: Int = 0

    private var selectedProgress: TaskProgress {
        TaskProgress.value(for: selectedProgressIndex)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.bodySpacing.rawValue) {
            headerView
                .animation(.easeInOut, value: selectedProgressIndex)

            taskListView
        }
        .onChange(of: selectedProgress) { newProgress in // TODO: мб вот этот OnChange можно убрать
            viewModel.updateProgress(newProgress)
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.createItem) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    @ViewBuilder
    private var headerView: some View {
        switch viewModel {
        case let viewModel as TasksViewModel:
            VStack(alignment: .leading, spacing: Constants.headerViewSpacing.rawValue) {
                Text("ID: \(viewModel.id)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(selectedProgress.description)
                    .font(.headline)
                    .transition(.slide)
            }
            .padding(.leading, Constants.padding.rawValue)
        default:
            EmptyView()
        }
    }

    @ViewBuilder
    private var taskListView: some View {
        switch viewModel {
        case let viewModel as TasksViewModel:
            TabView(selection: $selectedProgressIndex) {
                ForEach(TaskProgress.allCases.indices, id: \.self) { _ in
                    scrollView
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        case let viewModel as RoomsViewModel:
            scrollView
        default:
            EmptyView()
        }
    }

    private var scrollView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Constants.padding.rawValue) {
                ForEach(viewModel.items) { item in
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
            TasksView<TasksViewModel>(viewModel: TasksViewModel(currentRoom: room))
        default:
            EmptyView()

        }
    }
}
