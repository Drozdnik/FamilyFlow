import SwiftUI

struct TasksView: View {
    @ObservedObject var viewModel: TasksViewModel
    @State private var selectedProgressIndex: Int = 0

    private var selectedProgress: TaskProgress {
        TaskProgress.allCases[selectedProgressIndex]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
        VStack(alignment: .leading, spacing: 5) {
            // TODO: наздвание комнаты тоже приходит с бека
            Text("Комната: Living Room")
                .font(.title)
                .padding(.top)
            Text("ID: 12345")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text(selectedProgress.rawValue)
                .font(.headline)
                .transition(.slide)
        }
    }

    private var taskListView: some View {
        TabView(selection: $selectedProgressIndex) {
            ForEach(TaskProgress.allCases.indices, id: \.self) { index in
                let progress = TaskProgress.allCases[index]

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.filteredTasks) { task in
                            TasksCardView(task: task)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
                .tag(index)
                .onAppear {
                    viewModel.updateProgress(progress)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
    struct KanbanBoardView_Previews: PreviewProvider {
        static var previews: some View {
            let storage: TaskStorage = TaskStorageImpl(networkingService: NetworkingServiceImpl())
            let viewModel = TasksViewModel(taskStorage: storage, progress: .toDo)
            TasksView(viewModel: viewModel)
        }
    }
