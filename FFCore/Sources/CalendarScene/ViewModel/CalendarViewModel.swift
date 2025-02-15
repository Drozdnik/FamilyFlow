import UIKit

final class CalendarViewModel: ObservableObject {

    @Published var selectedWeek: Week
    @Published var selectedDay: Day

    private let tasksStorage: any TasksStorage

    init(tasksStorage: any TasksStorage) {
        self.tasksStorage = tasksStorage
        let generatedWeek = DateHelper.getWeek(for: Date.today)
        self.selectedWeek = generatedWeek
        self.selectedDay = DateHelper.findToday(in: generatedWeek.days)
    }
}
