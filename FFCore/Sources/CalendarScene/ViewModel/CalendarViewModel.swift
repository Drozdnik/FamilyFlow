import UIKit

final class CalendarViewModel: ObservableObject {
    private let tasksStorage: any TasksStorage

    init(tasksStorage: any TasksStorage) {
        self.tasksStorage = tasksStorage
    }
}
