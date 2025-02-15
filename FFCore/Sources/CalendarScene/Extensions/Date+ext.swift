import Foundation

extension Date {
    enum StripTimeType: CaseIterable {
        case month
        case days
        case minutes

        var rawValue: Set<Calendar.Component> {
            switch self {
            case .month: [.year, .month]
            case .days: [.year, .month, .day]
            case .minutes: [.year, .month, .day, .minute]
            }
        }
    }

    static let firstWeekdayIndex: Int = 2
    static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = Self.firstWeekdayIndex
        return calendar
    }()

    static var today: Day {
        Day(date: .now)
    }

    var isToday: Bool {
        Self.calendar.isDateInToday(self)
    }

    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func strip(to stripTimeType: Date.StripTimeType) -> Date {
        let components = Date.calendar.dateComponents(stripTimeType.rawValue, from: self)
        return Date.calendar.date(from: components) ?? self
    }
}
