import Foundation
import SwiftUI

public final class DIContainer: ObservableObject {
    let networkService: any NetworkingService
    let roomsStorage: any RoomsStorage

    public init(networkService: any NetworkingService, roomsStorage: any RoomsStorage) {
        self.networkService = networkService
        self.roomsStorage = roomsStorage
    }
}

public struct DIContainerKey: @preconcurrency EnvironmentKey {
    @MainActor public static let defaultValue: DIContainer = DIContainer(
        networkService: DummyNetworkingServiceImpl(),
        roomsStorage: DummyRoomsStorage()
    )
}

public extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
