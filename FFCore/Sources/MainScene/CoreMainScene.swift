import UIKit

public final class CoreMainScene: UITabBarController {
    private struct TabItem {
        let title: String?
        let image: UIImage?
        let selectedImage: UIImage?
        let viewController: UIViewController
    }

    private enum Constants {
        static let separatorHeight = 0.5
    }

    private enum Tab: Int, CaseIterable {
        case house
        case calendar
        case bag
        case profile
    }

    private let tabItems: [TabItem]

    public init() {
        self.tabItems = Self.createAndConfigureTabItems()
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }

    @MainActor
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.backgroundColor = .systemBackground
        tabBar.addTopBorder(with: UIColor.separator, height: Constants.separatorHeight)

        let controllers = tabItems.enumerated().map { index, tab in
            let controller = UINavigationController(rootViewController: tab.viewController)
            controller.tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem.tag = index
            return controller
        }
        setViewControllers(controllers, animated: true)
    }

    private static func createAndConfigureTabItems() -> [TabItem] {
        Tab.allCases.map { tab in
            TabItem(
                title: title(for: tab),
                image: image(for: tab),
                selectedImage: selectedImage(for: tab),
                viewController: viewController(for: tab)
            )
        }
    }

    private static func title(for tab: Tab) -> String? {
        switch tab {
        case .house:
            return "house"
        case .calendar:
            return "calendar"
        case .bag:
            return "bag"
        case .profile:
            return "person"
        }
    }

    private static func image(for tab: Tab) -> UIImage? {
        switch tab {
        case .house:
            return UIImage(systemName: "house")
        case .calendar:
            return UIImage(systemName: "calendar")
        case .bag:
            return UIImage(systemName: "bag")
        case .profile:
            return UIImage(systemName: "person")
        }
    }

    private static func selectedImage(for tab: Tab) -> UIImage? {
        switch tab {
        case .house:
            return UIImage(systemName: "house.fill")
        case .calendar:
            return UIImage(systemName: "calendar")
        case .bag:
            return UIImage(systemName: "bag.fill")
        case .profile:
            return UIImage(systemName: "person.fill")
        }
    }

    private static func viewController(for tab: Tab) -> UIViewController {
        switch tab {
        case .house:
            return OverviewRootViewController()
        case .calendar:
            return CalendarRootViewController()
        case .bag:
            return PurchasesRootViewController()
        case .profile:
            return ProfileRootViewContoller()
        }
    }
}

fileprivate extension UIView {
    func addTopBorder(with color: UIColor?, height: CGFloat) {
        guard let color else {
            return
        }
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleHeight, .flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        separator.frame = CGRect(x: 0, y: 0, width: frame.width, height: height)
        addSubview(separator)
    }
}
