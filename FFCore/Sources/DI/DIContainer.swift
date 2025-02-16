import Foundation
import SwiftUI

public final class DIContainer: ObservableObject {
    let networkService: any NetworkingService
    let roomsStorage: any RoomsStorage
    let tasksStorage: any TasksStorage

    public init(
        networkService: any NetworkingService,
        roomsStorage: any RoomsStorage,
        tasksStorage: any TasksStorage
    ) {
        self.networkService = networkService
        self.roomsStorage = roomsStorage
        self.tasksStorage = tasksStorage
    }
}

public struct DIContainerKey: @preconcurrency EnvironmentKey {
    @MainActor public static let defaultValue: DIContainer = DIContainer(
        networkService: DummyNetworkingServiceImpl(),
        roomsStorage: DummyRoomsStorage(),
        tasksStorage: DummyTasksStorage()
    )
}

public extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
