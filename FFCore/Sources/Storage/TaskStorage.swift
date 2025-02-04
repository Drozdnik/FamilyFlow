import Foundation

public protocol TaskStorage {
    var tasks: [TaskModel] { get }

    func add(task: TaskModel)
    func update(task: TaskModel)
    func delete(task: TaskModel)
}

public final class TaskStorageImpl: TaskStorage, ObservableObject {
    @Published
    public private(set) var tasks: [TaskModel] = []
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        tasks = networkingService.getData()
    }

    public func add(task: TaskModel) {}

    public func update(task: TaskModel) {}

    public func delete(task: TaskModel) {}
}
