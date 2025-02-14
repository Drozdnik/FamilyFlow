import Foundation

public extension Date {
    enum StripTimeType: CaseIterable {
        case month
        case days
        case minutes
    }

    static let firstWeekdayIndex: Int = 2
    static let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = Self.firstWeekdayIndex
        return calendar
    }()

    var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self) ?? self
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
        let components: DateComponents
        switch stripTimeType {
        case .month:
            components = Date.calendar.dateComponents([.year, .month], from: self)
        case .days:
            components = Date.calendar.dateComponents([.year, .month, .day], from: self)
        case .minutes:
            components = Date.calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        }
        return Date.calendar.date(from: components) ?? self

    }
}

public extension Optional where Wrapped == Date {
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return wrapped.toString(format: format)
        }
    }
}
