import Foundation

public protocol NetworkingService: Sendable {
    func getTasks(completion: (Result<[TaskItem], Error>) -> Void)
    func getRooms(completion: (Result<[Room], Error>) -> Void)
    func addTask()
    func updateTask()
    func deleteTask()
}

public struct DummyNetworkingServiceImpl: NetworkingService {
    public func getTasks(completion: (Result<[TaskItem], any Error>) -> Void) {}
    public func getRooms(completion: (Result<[Room], any Error>) -> Void) {}
    public func addTask() {}
    public func updateTask() {}
    public func deleteTask() {}
}
