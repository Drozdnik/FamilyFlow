import SwiftUI

struct WeekView: View {
    @Binding var selectedWeek: Week?

    private enum LayoutType {
        case custom(baseSize: CGFloat, largeSize: CGFloat)
        case `default`(size: CGFloat)
    }

    private enum Constants {
        static let height: CGFloat = 75.0
        static let padding: CGFloat = 8.0
    }

    var body: some View {
        GeometryReader { geometry in
            InfinitePageView(
                selection: $selectedWeek,
                before: { DateHelper.previousWeek(before: $0) },
                after: { DateHelper.nextWeek(after: $0) },
                view: { daysView(for: $0, geometry: geometry) }
            )
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.padding)
        }
    }

    @ViewBuilder
    private func daysView(for week: Week?, geometry: GeometryProxy) -> some View {
        if let week {
            let layoutType = calculateLayoutType(for: week, geometry: geometry)
            HStack(spacing: 0) {
                ForEach(week.days) { day in
                    let size: CGFloat
                    switch layoutType {
                    case .custom(let baseSize, let largeSize):
                        size = day.isToday ? largeSize : baseSize
                    case .default(let defaultSize):
                        size = defaultSize
                    }
                    return DayView(day: day, size: size)
                }
            }
        }
    }

    private func calculateLayoutType(
        for week: Week,
        geometry: GeometryProxy
    ) -> LayoutType {
        // swiftlint:disable no_magic_numbers
        let isCustomWeekLayout = week.days.contains(where: { $0.isToday })
        let totalSpacing: CGFloat = 8 * 6
        let sidePadding: CGFloat = 8 * 2
        let availableWidth = geometry.size.width - totalSpacing - sidePadding

        if isCustomWeekLayout {
            let baseSize = availableWidth / (6 + 1.2)
            let largeSize = baseSize * 1.2
            return .custom(baseSize: baseSize, largeSize: largeSize)
        }
        let squareSize = availableWidth / 7
        // swiftlint:enable no_magic_numbers

        return .default(size: squareSize)
    }
}
