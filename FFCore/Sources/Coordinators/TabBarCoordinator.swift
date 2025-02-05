import UIKit

public final class TabBarCoordinatorImpl: Coordinator {
    private let tabBarController: UITabBarController
    public var childCoordinators: [any Coordinator] = []

    public var rootViewController: UIViewController? {
        tabBarController
    }

    @MainActor public init() {
        self.tabBarController = UITabBarController()
    }

    public func start() {
        let networkService = NetworkingServiceImpl()
        let tasksStorage = TasksStorageImpl(networkingService: networkService)
        let tasksCoordinator = TasksCoordinatorImpl(tasksStorage: tasksStorage)

        childCoordinators.append(tasksCoordinator)
        childCoordinators.forEach { $0.start() }

        let coordinators: [Tab: any Coordinator] = [
            .tasks: tasksCoordinator
        ]

        let presenter = TabBarPresenter(coordinators: coordinators)
        tabBarController.viewControllers = presenter.tabItems
        presenter.configureTabBarAppearance(tabBarController.tabBar)
    }
}
