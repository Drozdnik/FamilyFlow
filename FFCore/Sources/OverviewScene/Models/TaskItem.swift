import Foundation

public struct TaskItem: Codable, Identifiable {
    public let id: Int

    let title: String
    let deadline: String
    let priority: String
    let assignee: String
    var progress: TaskProgress
}
