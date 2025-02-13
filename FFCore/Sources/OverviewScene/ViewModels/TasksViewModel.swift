import Combine
import Foundation

final class TasksViewModel: ObservableObject {
    @Published private(set) var filteredTasks: [TaskItem] = []
    private let tasksStorage: any TasksStorage
    private var cancellables = Set<AnyCancellable>()
    private var currentStatus: TaskProgress {
        didSet {
            filterTasks()
        }
    }

    init(tasksStorage: any TasksStorage, currentStatus: TaskProgress = .first) {
        self.tasksStorage = tasksStorage
        self.currentStatus = currentStatus
        bindTasks()
    }

    private func bindTasks() {
        if let storage = tasksStorage as? TasksStorageImpl {
            storage.$dataSource
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self else { return }
                    filterTasks()
                }
                .store(in: &cancellables)
        }
    }

    private func filterTasks() {
        filteredTasks = tasksStorage.dataSource.filter { $0.progress == currentStatus }
    }

    func updateProgress(_ newProgress: TaskProgress) {
        currentStatus = newProgress
    }

    func addTask(_ task: TaskItem) {
        tasksStorage.add(task)
    }

    func updateTask(_ task: TaskItem) {
        tasksStorage.update(task)
    }

    func deleteTask(_ task: TaskItem) {
        tasksStorage.delete(task)
    }
}
