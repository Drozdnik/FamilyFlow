import Foundation

public final class RoomItem: ObservableObject, Identifiable {
    public let id: String
    @Published var tasks: [TaskItem]
    let title: String
    let subTitle: String

    public init(
        id: String,
        tasks: [TaskItem],
        title: String,
        subTitle: String
    ) {
        self.id = id
        self.tasks = tasks
        self.title = title
        self.subTitle = subTitle
    }
}
