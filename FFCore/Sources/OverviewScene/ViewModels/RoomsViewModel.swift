import Foundation

final class RoomsViewModel: SlotsBaseViewModel {
    var items: [SlotsItem] {
        roomItems.map { .room($0) }
    }

    private var roomItems: [RoomItem] = []

    var title: String = "Комнаты"

    init(networkingService: NetworkingService) {
        networkingService.getRooms { result in
            switch result {
            case .success(let room):
                roomItems = room
            case .failure:
                break
            }
        }
    }

    func createItem() {}
}
