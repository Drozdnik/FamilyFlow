import Foundation

struct Day: Identifiable, Equatable, Hashable {
    let id: Double
    let date: Date

    var isToday: Bool {
        date.isToday
    }

    var dayOfWeek: Int {
        let components = Date.calendar.component(.weekday, from: date)
        let dayPerWeek = 7
        return (components - Date.firstWeekdayIndex) % dayPerWeek
    }

    init(id: Double? = nil, date: Date) {
        self.id = id ?? date.timeIntervalSince1970
        self.date = date.strip(to: .days)
    }
}
