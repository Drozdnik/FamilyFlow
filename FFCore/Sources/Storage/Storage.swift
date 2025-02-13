import Foundation

public protocol Storage {
    associatedtype Model

    var dataSource: [Model] { get }

    func add(_ model: Model)
    func update(_ model: Model)
    func delete(_ model: Model)
}

struct DummyTaskStorage: TasksStorage {
    var dataSource: [TaskItem] = []

    func add(_ model: TaskItem) {}
    func update(_ model: TaskItem) {}
    func delete(_ model: TaskItem) {}
}
