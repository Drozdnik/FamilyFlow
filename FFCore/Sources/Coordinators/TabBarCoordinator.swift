import UIKit

public final class TabBarCoordinatorImpl: Coordinator {
    private let tabBarController = UITabBarController()
    private var childCoordinators: [any Coordinator] = []

    public init() {}

    public func start() {
        let networkService = NetworkingServiceImpl()
        let tasksStorage = TasksStorageImpl(networkingService: networkService)
        let tasksCoordinator = TasksCoordinatorImpl(tasksStorage: tasksStorage)

        childCoordinators = [tasksCoordinator as any Coordinator]
        childCoordinators.forEach { $0.start() }

        let coordinators: [Tab: any Coordinator] = [
            .tasks: tasksCoordinator as any Coordinator
        ]

        let presenter = TabBarPresenter(coordinators: coordinators)
        tabBarController.viewControllers = presenter.tabItems
        presenter.configureTabBarAppearance(tabBarController.tabBar)
    }

    public var rootViewController: UIViewController {
        tabBarController
    }
}
