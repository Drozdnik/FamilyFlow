import SwiftUI

enum TabItem: CaseIterable {
    case tasks
    case calendar
    case bag
    case profile

    var title: String {
        switch self {
        case .tasks: return "Tasks"
        case .calendar: return "Calendar"
        case .bag: return "Bag"
        case .profile: return "Profile"
        }
    }

    var image: String {
        switch self {
        case .tasks: "house"
        case .calendar: "calendar"
        case .bag: "bag"
        case .profile: "person"
        }
    }
}
