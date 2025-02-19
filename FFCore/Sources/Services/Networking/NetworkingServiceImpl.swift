import Foundation
protocol ApiEndpoint {
    associatedtype Response
}

struct RoomsEndPoint: ApiEndpoint {
    typealias Response = [RoomItem]
}

struct TasksEndPoint: ApiEndpoint {
    typealias Response = [TaskItem]
}
public final class NetworkingServiceImpl: NetworkingService {

    public init() {}

    private func getData<T: ApiEndpoint>(for endPoint: T, completion: (Result<T.Response, Error>) -> Void) {
        // swiftlint:disable force_cast
        if endPoint is RoomsEndPoint {
            completion(.success(mockRooms as! T.Response))
        } else if endPoint is TasksEndPoint {
            completion(.success(mockTasks as! T.Response))
        } else {
            completion(.failure(NSError(domain: "Unknown Enpoint", code: -1)))
        }
        // swiftlint:enable force_cast
    }

    public func getRooms(completion: (Result<[RoomItem], Error>) -> Void) {
        let endPoint = RoomsEndPoint()
        getData(for: endPoint, completion: completion)
    }

    public func getTasks(completion: (Result<[TaskItem], Error>) -> Void) {
        let endPoint = TasksEndPoint()
        getData(for: endPoint, completion: completion)
    }

    // TODO: Добавить возвращаемый тип, подумать каким он будет
    public func addTask() {}

    public func updateTask() {}

    public func deleteTask() {}
}

nonisolated(unsafe) private let mockTasks = [
    TaskItem(
        id: 1,
        title: "Задача 1",
        deadline: "05.01.2025",
        priority: "Высокая",
        assignee: "Петя",
        progress: .first
    ),
    TaskItem(
        id: 2,
        title: "Задача 2",
        deadline: "06.01.2025",
        priority: "Средняя",
        assignee: "Оля",
        progress: .second
    ),
    TaskItem(
        id: 3,
        title: "Задача 3",
        deadline: "07.01.2025",
        priority: "Низкая",
        assignee: "Саша",
        progress: .third
    )
]

nonisolated(unsafe) private let mockRooms = [
    RoomItem(id: "1", tasks: mockTasks, title: "Рабочее", subTitle: "Здесь рабочие задачи"),
    RoomItem(id: "2", tasks: mockTasks, title: "Дом", subTitle: "Здесь находятся домашние задачи")
]
