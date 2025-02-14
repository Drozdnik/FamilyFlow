import UIKit

final class CalendarViewModel: ObservableObject {

    @Published
    var selectedWeek: Week?

    private let tasksStorage: any TasksStorage

    init(tasksStorage: any TasksStorage) {
        self.tasksStorage = tasksStorage
        let generatedWeeks = DateHelper.generateWeeks(in: Date.now, with: 1)
        self.selectedWeek = generatedWeeks.middle
    }
}

private extension Array {
    var middle: Element? {
        guard !isEmpty else {
            assertionFailure()
            return nil
        }
        let two = 2
        return self[count / two]
    }
}
