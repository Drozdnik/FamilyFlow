import Foundation

enum TaskProgress: String, CaseIterable, Codable {
    case toDo = "To Do"
    case inProgress = "In Progress"
    case done = "Done"
}
