import Combine
import Foundation

@MainActor
final class TasksViewModel: ObservableObject {
    @Published var filteredTasks: [TaskModel] = []
    private let taskStorage: TaskStorage
    private var cancellables = Set<AnyCancellable>()
    private var currentProgress: TaskProgress = .toDo

    init(taskStorage: TaskStorage, progress: TaskProgress = .toDo) {
        self.taskStorage = taskStorage
        self.currentProgress = progress
        bindTasks()
    }

    private func bindTasks() {
        if let storage = taskStorage as? TaskStorageImpl {
            storage.$tasks
                .receive(on: DispatchQueue.main)
                .sink { [weak self] tasks in
                    self?.filteredTasks = tasks.filter { $0.progress == self?.currentProgress }
                }
                .store(in: &cancellables)
        }
    }

    func updateProgress(_ newProgress: TaskProgress) {
        currentProgress = newProgress
        bindTasks()
    }

    func addTask(_ task: TaskModel) {
        taskStorage.add(task: task)
    }

    func updateTask(_ task: TaskModel) {
        taskStorage.update(task: task)
    }

    func deleteTask(_ task: TaskModel) {
        taskStorage.delete(task: task)
    }
}
