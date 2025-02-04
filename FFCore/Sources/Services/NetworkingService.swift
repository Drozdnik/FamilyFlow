import Foundation

// enum ViewData {
//    case kanban
//    case calendar
//    case purchase
//    case profile
// }

protocol NetworkingService {
    func getData() -> [TaskModel]
    func addTask()
    func updateTask()
    func deleteTask()
}

final class NetworkingServiceImpl: NetworkingService {

    init() {}

    func getData() -> [TaskModel] {
        let mockTasks = [
            TaskModel(
                id: 1,
                title: "Задача 1",
                deadline: "05.01.2025",
                priority: "Высокая",
                assignee: "Петя",
                progress: .toDo
            ),
            TaskModel(
                id: 2,
                title: "Задача 2",
                deadline: "06.01.2025",
                priority: "Средняя",
                assignee: "Оля",
                progress: .inProgress
            ),
            TaskModel(
                id: 3,
                title: "Задача 3",
                deadline: "07.01.2025",
                priority: "Низкая",
                assignee: "Саша",
                progress: .done
            )
        ]

        return mockTasks
    }

    // TODO: Добавить возвращаемый тип, подумать каким он будет
    func addTask() {}

    func updateTask() {}

    func deleteTask() {}

}
