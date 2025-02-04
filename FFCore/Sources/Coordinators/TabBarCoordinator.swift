import UIKit

public final class TabBarCoordinatorImpl: Coordinator {
    public let tabBarController = UITabBarController()
    private let taskStorage: TaskStorage
    private var childCoordinators: [Coordinator] = []

    public init() {
        let networkService: NetworkingService = NetworkingServiceImpl()
        taskStorage = TaskStorageImpl(networkingService: networkService)
    }

    public func start() {
        let tasksCoordinator = TasksCoordinatorImpl(taskStorage: taskStorage)

        childCoordinators = [tasksCoordinator]
        childCoordinators.forEach { $0.start() }

        let coordinators: [Tab: Coordinator] = [
            .tasks: tasksCoordinator
        ]

        let presenter = TabBarPresenter(coordinators: coordinators)
        tabBarController.viewControllers = presenter.tabItems

        tabBarController.tabBar.tintColor = .label
        tabBarController.tabBar.backgroundColor = .systemBackground
    }

    public var rootViewController: UIViewController {
        tabBarController
    }
}
