import Foundation

enum SlotsItem: Identifiable {
    var id: String {
        switch self {
        case .room(let item):
            item.id
        case .task(let item):
            "\(item.id)"
        }
    }

    case task(TaskItem)
    case room(RoomItem)
}

protocol SlotsBaseViewModel {
    var title: String { get }
    var items: [SlotsItem] { get }

    func updateProgress(_ progress: TaskProgress)
    func createItem()
}

extension SlotsBaseViewModel {
    func updateProgress(_: TaskProgress) {}
}
