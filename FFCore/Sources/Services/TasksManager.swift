import Foundation

protocol TasksManager {
    func add(_ model: TaskItem)

    func update(_ model: TaskItem)

    func delete(_ model: TaskItem)
}

final class TasksManagerImpl: TasksManager {

    init() {}

    func add(_ model: TaskItem) {}

    func update(_ model: TaskItem) {}

    func delete(_ model: TaskItem) {}
}
