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

    static func getWeek(for date: Date) -> Week? {
        guard let startOfWeek = Date.calendar.date(
            from: Date.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        ) else {
            return nil
        }

        let dayOfWeekRange = 0..<7
        let days: [Day] = dayOfWeekRange.compactMap { index in
            guard let day = Date.calendar.date(byAdding: .day, value: index, to: startOfWeek) else {
                return nil
            }
            return Day(date: day)
        }

        return Week(days: days)
    }

    static func formatMonthRange(from startDate: Date, to endDate: Date) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"

        let startMonth = dateFormatter.string(from: startDate).capitalized
        let endMonth = dateFormatter.string(from: endDate).capitalized

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        let startYear = yearFormatter.string(from: startDate)
        let endYear = yearFormatter.string(from: endDate)

        if startYear == endYear {
            if calendar.isDate(startDate, equalTo: endDate, toGranularity: .month) {
                return "\(startMonth), \(startYear)"
            }
            return "\(startMonth) - \(endMonth), \(startYear)"
        }
        return "\(startMonth) \(startYear) - \(endMonth) \(endYear)"
    }

    static func generateWeeks(in centerDate: Date, with range: Int = 2) -> [Week] {
        var weeks: [Week] = []

        for offset in -range...range {
            if let weekDate = Date.calendar.date(byAdding: .weekOfYear, value: offset, to: centerDate),
               let week = Self.getWeek(for: weekDate) {
                weeks.append(week)
            }
        }

        return weeks
    }

    static func previousWeek(before week: Week? = nil) -> Week? {
        guard
            let firstDay = week?.firstDay,
            let previousWeekDate = Date.calendar.date(byAdding: .weekOfYear, value: -1, to: firstDay),
            let previousWeek = Self.getWeek(for: previousWeekDate)
        else {
            return nil
        }

        return previousWeek

    }

    static func nextWeek(after week: Week? = nil) -> Week? {
        guard
            let firstDay = week?.firstDay,
            let nextWeekDate = Date.calendar.date(byAdding: .weekOfYear, value: +1, to: firstDay),
            let nextWeek = Self.getWeek(for: nextWeekDate)
        else {
            return nil
        }

        return nextWeek
    }
}
