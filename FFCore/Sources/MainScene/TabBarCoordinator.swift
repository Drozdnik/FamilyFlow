import UIKit

public final class TabBarCoordinator: Coordinator {

    public init() {}

    public let  tabBarController: UITabBarController = UITabBarController()

    public func start() {
        let presenter = TabBarPresenter()
        let viewControllers = presenter.tabItems

        tabBarController.setViewControllers(viewControllers, animated: true)
        tabBarController.tabBar.tintColor = .label
        tabBarController.tabBar.unselectedItemTintColor = .secondaryLabel
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.addTopBorder(with: .separator)
    }
}

private extension UIView {
    func addTopBorder(with color: UIColor?) {
        let topBorderHeight = 0.5
        guard let color else { return }
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        separator.frame = CGRect(x: 0, y: 0, width: frame.width, height: topBorderHeight)
        addSubview(separator)
    }
}
