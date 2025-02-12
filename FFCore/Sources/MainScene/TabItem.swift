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

    var selectedImage: UIImage {
        switch self {
        case .tasks: return UIImage(systemName: "house.fill")!
        case .calendar: return UIImage(systemName: "calendar.circle.fill")!
        case .bag: return UIImage(systemName: "bag.fill")!
        case .profile: return UIImage(systemName: "person.fill")!
        }
    }
}
