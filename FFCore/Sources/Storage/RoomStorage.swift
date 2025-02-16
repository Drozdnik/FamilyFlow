import Foundation

public protocol RoomsStorage: Storage where Model == Room { }

public final class RoomsStorageImpl: RoomsStorage, ObservableObject {

    @Published
    public private(set) var dataSource: [Room] = []
    private let networkingService: NetworkingService

    public init(networkingService: NetworkingService) {
        self.networkingService = networkingService
        networkingService.getRooms(completion: { result in
            switch result {
            case .success(let rooms):
                dataSource = rooms
            case .failure:
                break
            }
        })
    }

    public func add(_ model: Room) {}

    public func update(_ model: Room) {}

    public func delete(_ model: Room) {}
}

public final class DummyRoomsStorage: RoomsStorage {
    public var dataSource: [Room] = []

    public init() {}

    public func add(_ model: Room) {}

    public func update(_ model: Room) {}

    public func delete(_ model: Room) {}
}
