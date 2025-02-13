import Foundation

enum TaskProgress: Int, CaseIterable, Codable {
    case first = 0
    case second = 1
    case third = 2

    var description: String {
        switch self {
        case .first: return "To Do"
        case .second: return "In Progress"
        case .third: return "Done"
        }
    }

    static func value(for index: Int) -> Self {
        guard let progress = Self(rawValue: index) else {
            fatalError("Invalid index for TaskProgress: \(index)")
        }
        return progress
    }
}
