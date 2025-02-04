import Foundation

public protocol Storage {
    associatedtype Model
    var tasks: [Model] { get }

    func add(task: Model)
    func update(task: Model)
    func delete(task: Model)
}

public final class TasksStorageImpl: Storage, ObservableObject {
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
