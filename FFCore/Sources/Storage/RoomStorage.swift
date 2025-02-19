import Foundation

public protocol RoomsStorage: Storage where Model == RoomItem { }

public final class RoomsStorageImpl: RoomsStorage, ObservableObject {

    @Published
    public private(set) var dataSource: [RoomItem] = []
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

    public func add(_ model: RoomItem) {}

    public func update(_ model: RoomItem) {}

    public func delete(_ model: RoomItem) {}
}

public final class DummyRoomsStorage: RoomsStorage {
    public var dataSource: [RoomItem] = []

    public init() {}

    public func add(_ model: RoomItem) {}

    public func update(_ model: RoomItem) {}

    public func delete(_ model: RoomItem) {}
}
