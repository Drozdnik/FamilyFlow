import SwiftUI

struct TasksView: View {
    @ObservedObject private(set) var viewModel: TasksViewModel
    @State private var selectedProgressIndex: Int = 0

    private var selectedProgress: TaskProgress {
        TaskProgress.value(for: selectedProgressIndex)
    }

    enum Constants: Double {
        case bodySpacing = 20.0
        case headerViewSpacing = 5.0
        case taskListViewSpacing = 10.0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.bodySpacing.rawValue) {
            headerView
                .animation(.easeInOut, value: selectedProgressIndex)
            taskListView
        }
        .padding()
        .onChange(of: selectedProgress) { newProgress in
            viewModel.updateProgress(newProgress)
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: Constants.headerViewSpacing.rawValue) {
            // TODO: наздвание комнаты тоже приходит с бека
            Text("Комната: Living Room")
                .font(.title)
                .padding(.top)
            Text("ID: 12345")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(selectedProgress.description)
                .font(.headline)
                .transition(.slide)
        }
    }

    private var taskListView: some View {
        TabView(selection: $selectedProgressIndex) {
            ForEach(TaskProgress.allCases.indices, id: \.self) { index in
                let progress = TaskProgress.value(for: index)

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: Constants.taskListViewSpacing.rawValue) {
                        ForEach(viewModel.filteredTasks) { task in
                            TasksCardView(task: task)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
