import Foundation

public protocol NetworkingService: Sendable {
    func getData() -> [Room]
    func addTask()
    func updateTask()
    func deleteTask()
}

public struct DummyNetworkingServiceImpl: NetworkingService {
    public func getData() -> [Room] { [] }
    public func addTask() {}
    public func updateTask() {}
    public func deleteTask() {}
}
