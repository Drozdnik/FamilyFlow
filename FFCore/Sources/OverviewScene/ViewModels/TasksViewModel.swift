import Combine
import Foundation

@MainActor
final class TasksViewModel<TasksStorage: Storage>: ObservableObject where TasksStorage.Model == TaskModel {
    @Published var filteredTasks: [TaskModel] = []
    private let tasksStorage: TasksStorage
    private var cancellables = Set<AnyCancellable>()
    private var currentStatus: TaskProgress {
        didSet {
            filterTasks()
        }
    }

    init(tasksStorage: TasksStorage, progress: TaskProgress = .first) {
        self.tasksStorage = tasksStorage
        self.currentStatus = progress
        bindTasks()
    }

    private func bindTasks() {
        if let storage = tasksStorage as? TasksStorageImpl {
            storage.$tasks
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self else { return }
                    filterTasks()
                }
                .store(in: &cancellables)
        }
    }

   private func filterTasks() {
        filteredTasks = tasksStorage.tasks.filter { $0.progress == currentStatus }
    }

    func updateProgress(_ newProgress: TaskProgress) {
        currentStatus = newProgress
    }

    func addTask(_ task: TaskModel) {
        tasksStorage.add(task: task)
    }

    func updateTask(_ task: TaskModel) {
        tasksStorage.update(task: task)
    }

    func deleteTask(_ task: TaskModel) {
        tasksStorage.delete(task: task)
    }
}
