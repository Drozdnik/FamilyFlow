import SwiftUI

struct WeekView: View {
    typealias LayoutParameters = DayView.LayoutParameters

    @Binding var selectedWeek: Week
    @Binding var selectedDay: Day

    private enum Constants {
        static let height: CGFloat = 75.0
        static let padding: CGFloat = 4.0

        static let todayLineWidth: CGFloat = 2.0
        static let defaultLineWidth: CGFloat = 1.0

        static let selectedFontSize: CGFloat = 20.0
        static let defaultFontSize: CGFloat = 16.0

        static let selectedStrokeColor: Color = .gray
        static let defaultStrokeColor: Color = .lightGray

        static let opacity: CGFloat = 0.3
        static let todayBackgroundColor: Color = Color.lightGray
        static let defaultBackgroundColor: Color = .clear
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

    private func daysView(for week: Week, geometry: GeometryProxy) -> some View {
        HStack(spacing: 0) {
            let size = calculateLayout(geometry: geometry)
            ForEach(week.days) { day in
                let layoutParameters = calculateLayoutParametrs(for: day, size: size)
                DayView(selectedDay: $selectedDay, day: day, layoutParameters: layoutParameters)
            }
        }
    }

    private func calculateLayout(geometry: GeometryProxy) -> (base: CGFloat, large: CGFloat) {
        // swiftlint:disable no_magic_numbers
        let totalSpacing: CGFloat = 8 * 6
        let sidePadding: CGFloat = 8 * 2
        let availableWidth = geometry.size.width - totalSpacing - sidePadding
        let baseSize = availableWidth / (6 + 1.2)
        let largeSize = baseSize * 1.2
        // swiftlint:enable no_magic_numbers

        return (baseSize, largeSize)
    }

    private func calculateLayoutParametrs(for day: Day, size: (base: CGFloat, large: CGFloat)) -> LayoutParameters {
        let cellSize = calculateCellSize(for: day, size: size)
        let lineWidth = day.isToday ? Constants.todayLineWidth : Constants.defaultLineWidth
        let strokeColor = day == selectedDay ? Constants.selectedStrokeColor : Constants.defaultStrokeColor
        let fontSize = day == selectedDay ? Constants.selectedFontSize : Constants.defaultFontSize
        let backgroundColor =
            day.isToday ? Constants.todayBackgroundColor.opacity(Constants.opacity) : Constants.defaultBackgroundColor

        return LayoutParameters(
            size: cellSize,
            lineWidth: lineWidth,
            strokeColor: strokeColor,
            fontSize: fontSize,
            backgroundColor: backgroundColor
        )
    }

    private func calculateCellSize(for day: Day, size: (base: CGFloat, large: CGFloat)) -> CGFloat {
        if selectedWeek.days.contains(selectedDay) {
            return day == selectedDay ? size.large : size.base
        }
        if day.dayOfWeek == selectedDay.dayOfWeek {
            Task {
                await MainActor.run {
                    selectedDay = day
                }
            }
            return size.large
        }
        return size.base
    }
}
