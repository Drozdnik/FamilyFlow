import Foundation
import SwiftUI

public final class DIContainer: ObservableObject {
    let networkService: any NetworkingService
    let tasksStorage: any TasksStorage

    public init(networkService: any NetworkingService, tasksStorage: any TasksStorage) {
        self.networkService = networkService
        self.tasksStorage = tasksStorage
    }
}

public struct DIContainerKey: @preconcurrency EnvironmentKey {
    @MainActor public static let defaultValue: DIContainer = DIContainer(
        networkService: DummyNetworkingServiceImpl(),
        tasksStorage: DummyTaskStorage()
    )
}

public extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
