import Foundation

enum DateHelper {
    enum Format {
        case long
        case short
    }

    static func convertToString(_ date: Date?, format: Format) -> String {
        guard let date else { return "" }
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEE"
        let dayOfWeek = dayOfWeekFormatter.string(from: date)

        let day = date.toString(format: "dd")
        let month = date.toString(format: "MMM")
        let year = date.toString(format: "YYYY")
        switch format {
        case .long:
            return [day, month, year].joined(separator: " ")
        case .short:
            return [day, dayOfWeek].joined(separator: "\n")
        }
    }

    static func getWeek(for day: Day) -> Week {
        getWeek(for: day.date)
    }

    static func getWeek(for date: Date) -> Week {
        guard let startOfWeek = Date.calendar.date(
            from: Date.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        ) else {
            fatalError("Unexpected error occurred")
        }

        let dayOfWeekRange = 0..<7
        let days: [Day] = dayOfWeekRange.compactMap { index in
            guard let dayDate = Date.calendar.date(byAdding: .day, value: index, to: startOfWeek) else {
                fatalError("Unexpected error occurred")
            }
            return Day(date: dayDate)
        }

        return Week(days: days)
    }

    static func formatMonthRange(from startDay: Day, to endDay: Day) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"

        let startMonth = dateFormatter.string(from: startDay.date).capitalized
        let endMonth = dateFormatter.string(from: endDay.date).capitalized

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        let startYear = yearFormatter.string(from: startDay.date)
        let endYear = yearFormatter.string(from: endDay.date)

        if startYear == endYear {
            if calendar.isDate(startDay.date, equalTo: endDay.date, toGranularity: .month) {
                return "\(startMonth), \(startYear)"
            }
            return "\(startMonth) - \(endMonth), \(startYear)"
        }
        return "\(startMonth) \(startYear) - \(endMonth) \(endYear)"
    }

    static func findToday(in arr: [Day]) -> Day {
        arr.first(where: { $0.isToday }) ?? arr.first ?? Date.today
    }

    static func previousWeek(before week: Week) -> Week {
        let firstDay = week.firstDay
        guard let previousWeekDate = Date.calendar.date(byAdding: .weekOfYear, value: -1, to: firstDay.date) else {
            fatalError("Unexpected error occurred")
        }
        let previousWeek = Self.getWeek(for: previousWeekDate)

        return previousWeek

    }

    static func nextWeek(after week: Week) -> Week {
        let firstDay = week.firstDay
        guard let nextWeekDate = Date.calendar.date(byAdding: .weekOfYear, value: +1, to: firstDay.date) else {
            fatalError("Unexpected error occurred")
        }
        let nextWeek = Self.getWeek(for: nextWeekDate)

        return nextWeek
    }
}
