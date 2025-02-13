import Foundation

public final class NetworkingServiceImpl: NetworkingService {

    public init() {}

    public func getData() -> [TaskItem] {
        let mockTasks = [
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

        return mockTasks
    }

    // TODO: Добавить возвращаемый тип, подумать каким он будет
    public func addTask() {}

    public func updateTask() {}

    public func deleteTask() {}
}
