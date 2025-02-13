import UIKit

final class CalendarViewModel: ObservableObject {
    let tasksStorage: any TasksStorage

    init(tasksStorage: any TasksStorage) {
        self.tasksStorage = tasksStorage
    }
}
