import SwiftUI
import UIKit

struct CalendarNavbar: View {
    @Binding var selectedWeek: Week
    @Binding var selectedDay: Day

    private enum Constants {
        static let textFontSize: CGFloat = 22.0
        static let navbarHeight: CGFloat = 108.0

        static let padding: CGFloat = 4.0
        static let textPadding: CGFloat = 14.0

        static let shadowRadius: CGFloat = 1.5
        static let shadowOffset: CGFloat = 3.0
        static let shadowOpacity: CGFloat = 0.2
    }

    var body: some View {
        VStack(spacing: Constants.padding) {
            navigationTitle()
            WeekView(selectedWeek: $selectedWeek, selectedDay: $selectedDay)
            Divider()
        }
        .frame(height: Constants.navbarHeight)
        .background(backgroundRectangle)
    }

    private var backgroundRectangle: some View {
        Rectangle()
            .fill(Color.systemBackground)
            .shadow(
                color: Color.black.opacity(Constants.shadowOpacity),
                radius: Constants.shadowRadius,
                y: Constants.shadowOffset
            )
    }

    private func navigationTitle() -> some View {
        HStack {
            Text(selectedWeek.monthName)
                .padding(.horizontal, Constants.textPadding)
                .font(.system(size: Constants.textFontSize))
                .bold()
            Spacer()
        }
    }
}
