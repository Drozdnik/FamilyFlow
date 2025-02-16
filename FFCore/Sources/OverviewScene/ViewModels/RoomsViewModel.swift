import Foundation

final class RoomsViewModel: TasksBaseVM {
    var title: String = "Комнаты"
    private(set) var items: [Room] = []

    init(networkingService: NetworkingService) {
        networkingService.getRooms { result in
            switch result {
            case .success(let room):
                items = room
            case .failure:
                break
            }
        }
    }

    func createItem() {}
}
