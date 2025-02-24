import Foundation

public protocol NetworkingService: Sendable {
    func getData() -> [TaskItem]
    func addTask()
    func updateTask()
    func deleteTask()
}

public struct DummyNetworkingServiceImpl: NetworkingService {
    public func getData() -> [TaskItem] { [] }
    public func addTask() {}
    public func updateTask() {}
    public func deleteTask() {}
}
