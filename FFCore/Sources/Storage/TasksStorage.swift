import Foundation

public protocol Storage {
    associatedtype Model

    var dataSource: [Model] { get }

    func add(_ model: Model)
    func update(_ model: Model)
    func delete(_ model: Model)
}

public final class TasksStorageImpl: Storage, ObservableObject {

    @Published
    public private(set) var dataSource: [TaskModel] = []
    private let networkingService: NetworkingService

    public init(networkingService: NetworkingServiceImpl) {
        self.networkingService = networkingService
        dataSource = networkingService.getData()
    }

    public func add(_ model: TaskModel) {}

    public func update(_ model: TaskModel) {}

    public func delete(_ model: TaskModel) {}
}
