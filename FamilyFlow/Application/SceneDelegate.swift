import FFCore
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var tabBarCoordinator: (any Coordinator)?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        let tabBarCoordinator: any Coordinator = TabBarCoordinatorImpl()
        self.tabBarCoordinator = tabBarCoordinator

        tabBarCoordinator.start()
        window.rootViewController = tabBarCoordinator.rootViewController
        window.makeKeyAndVisible()

        self.window = window
    }
}
