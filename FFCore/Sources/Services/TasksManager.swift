import Foundation

public protocol TasksManager {
    func add(_ model: TaskItem)

    func update(_ model: TaskItem)

    func delete(_ model: TaskItem)
}

public final class TasksManagerImpl: TasksManager {

    public init() {}

    public func add(_ model: TaskItem) {}

    public func update(_ model: TaskItem) {}

    public func delete(_ model: TaskItem) {}
}
