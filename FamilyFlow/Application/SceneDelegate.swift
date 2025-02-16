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
        let roomsStorage = RoomsStorageImpl(networkingService: networkService)
        let tasksStorage = TasksStorageImpl(networkingService: networkService)
        let diContainer = DIContainer(
            networkService: networkService,
            roomsStorage: roomsStorage,
            tasksStorage: tasksStorage
        )
        window.rootViewController = UIHostingController(
            rootView: RootView()
                .environment(\.diContainer, diContainer)
        )
        window.makeKeyAndVisible()

        self.window = window
    }
}
