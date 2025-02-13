import FFCore
import SwiftUI
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)

        let networkService = NetworkingServiceImpl()
        let taskStorage = TasksStorageImpl(networkingService: networkService)
        let diContainer = DIContainer(networkService: networkService, tasksStorage: taskStorage)
        window.rootViewController = UIHostingController(
            rootView: RootView()
                .environmentObject(diContainer)
        )
        window.makeKeyAndVisible()

        self.window = window
    }
}
