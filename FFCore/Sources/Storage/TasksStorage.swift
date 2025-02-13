import Foundation

public protocol TasksStorage: Storage where Model == TaskItem { }

public final class TasksStorageImpl: TasksStorage, ObservableObject {

    @Published
    public private(set) var dataSource: [TaskItem] = []
    private let networkingService: NetworkingService

    public init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        dataSource = networkingService.getData()
    }

    public func add(_ model: TaskItem) {}

    public func update(_ model: TaskItem) {}

    public func delete(_ model: TaskItem) {}
}
