import Combine
import Foundation

final class TasksViewModel: SlotsBaseViewModel, ObservableObject {

    private(set) var title: String
    @Published private(set) var filteredTasks: [TaskItem] = []
    var items: [SlotsItem] {
        filteredTasks.map { .task($0) }
    }
    var id: String {
        currentRoom.id
    }

    private let tasksManager: TasksManager
    private let currentRoom: RoomItem
    private var cancellables = Set<AnyCancellable>()
    private var currentStatus: TaskProgress {
        didSet {
            filterTasks()
        }
    }
    var progressDescription: String {
        currentStatus.description
    }

    init(
        currentRoom: RoomItem,
        currentStatus: TaskProgress = .first
    ) {
        tasksManager = TasksManagerImpl()
        self.currentRoom = currentRoom
        self.currentStatus = currentStatus
        title = currentRoom.title
        bindTasks()
    }

    private func bindTasks() {
        currentRoom.$tasks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                filterTasks()
            }
            .store(in: &cancellables)
    }

    private func filterTasks() {
        filteredTasks = currentRoom.tasks.filter { $0.progress == currentStatus }
    }

    func updateProgress(_ newProgress: TaskProgress) {
        currentStatus = newProgress
    }

    func createItem() {
    }

    func updateTask(_ task: TaskItem) {
        tasksManager.update(task)
    }

    func deleteTask(_ task: TaskItem) {
        tasksManager.delete(task)
    }
}
