import Foundation

public final class DIContainer<TaskStorage: Storage>: ObservableObject where TaskStorage.Model == TaskModel {
    let networkService: NetworkingService
    let tasksStorage: TaskStorage
    let tasksViewModel: TasksViewModel<TaskStorage>

    public init(networkService: NetworkingServiceImpl, tasksStorage: TaskStorage) {
        self.networkService = networkService
        self.tasksStorage = tasksStorage
        tasksViewModel = TasksViewModel(tasksStorage: tasksStorage)
    }
}
