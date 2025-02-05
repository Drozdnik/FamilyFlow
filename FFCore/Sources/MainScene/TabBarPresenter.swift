import SwiftUI

@MainActor
final class TabBarPresenter {
    private(set) var tabItems: [UIViewController] = []
    private let coordinators: [Tab: Coordinator]

    init(coordinators: [Tab: Coordinator]) {
        self.coordinators = coordinators
        makeTabItems()
    }

    func configureTabBarAppearance(_ tabBar: UITabBar) {
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
    }

    private func makeTabItems() {
        tabItems = Tab.allCases.map { tab in
            let viewController = coordinators[tab]?.rootViewController ?? defaultViewController(for: tab)
            viewController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.image,
                selectedImage: tab.selectedImage
            )

            return viewController
        }
    }

    private func defaultViewController(for tab: Tab) -> UIViewController {
        let label = UILabel()
        label.text = "\(tab.title) - В разработке"
        label.textAlignment = .center

        let viewController = UIViewController()
        viewController.view = label

        return viewController
    }
}

enum Tab: CaseIterable {
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

    var image: UIImage {
        switch self {
        case .tasks: return UIImage(systemName: "house")!
        case .calendar: return UIImage(systemName: "calendar")!
        case .bag: return UIImage(systemName: "bag")!
        case .profile: return UIImage(systemName: "person")!
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
