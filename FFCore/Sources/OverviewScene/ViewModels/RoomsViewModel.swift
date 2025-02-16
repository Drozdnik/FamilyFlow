import Foundation

final class RoomsViewModel: TasksBaseVM {
    var title: String = "Комнаты"
    private(set) var items: [Room]

    init(networkingService: NetworkingService) {
        items = networkingService.getData()
    }

    func createItem() {}
}
