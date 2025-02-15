import Foundation

struct Week: Hashable, Equatable, Identifiable {
    let id: Double
    let days: [Day]

    init(id: Double? = nil, days: [Day]) {
        let firstDate = days.first?.date ?? .distantFuture
        self.id = id ?? firstDate.timeIntervalSince1970
        self.days = days
    }

    var monthName: String {
        DateHelper.formatMonthRange(from: firstDay, to: lastDay)
    }

    var firstDay: Day {
        days.first.flatMap({ Day(date: $0.date) }) ?? Date.today
    }

    var lastDay: Day {
        days.last.flatMap({ Day(date: $0.date) }) ?? firstDay
    }
}
