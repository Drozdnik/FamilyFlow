import Foundation

struct Day: Identifiable, Equatable, Hashable {
    let id: Double
    let date: Date

    var isToday: Bool {
        date.isToday
    }

    init(id: Double? = nil, date: Date) {
        self.id = id ?? date.timeIntervalSince1970
        self.date = date
    }
}
