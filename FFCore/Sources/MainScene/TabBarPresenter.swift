import UIKit

@MainActor
public final class TabBarPresenter {
    private(set) var tabItems: [UIViewController] = []
    
    public init() {
        makeTabItems()
    }
    
    private func makeTabItems() {
        tabItems = Tab.allCases.map { tab in
            let viewController = makeViewController(for: tab)
            viewController.tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.image,
                selectedImage: tab.selectedImage
            )
            return viewController
        }
    }
    
    private func makeViewController(for tab: Tab) -> UIViewController {
        switch tab {
        case .house:
            OverviewRootViewController()
        case .calendar:
            CalendarRootViewController()
        case .bag:
            PurchasesRootViewController()
        case .profile:
            ProfileRootViewContoller()
        }
    }
}

private enum Tab: CaseIterable {
    case house
    case calendar
    case bag
    case profile
    
    var title: String {
        switch self {
        case .house:
            "house"
        case .calendar:
            "calendar"
        case .bag:
            "bag"
        case .profile:
            "profile"
        }
    }
    
    var image: UIImage {
        switch self {
        case .house:
            UIImage(systemName: "house")!
        case .calendar:
            UIImage(systemName: "calendar")!
        case .bag:
            UIImage(systemName: "bag")!
        case .profile:
            UIImage(systemName: "person")!
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .house:
            UIImage(systemName: "house.fill")!
        case .calendar:
            UIImage(systemName: "calendar")!
        case .bag:
            UIImage(systemName: "bag.fill")!
        case .profile:
            UIImage(systemName: "person.fill")!
        }
    }
}
