import SwiftUI

struct DayView: View {
    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
        static let aspectRatio: CGFloat = 1.2
        static let shadowRadius: CGFloat = 2.0
        static let opacity: CGFloat = 0.3

        static let padding: CGFloat = 4.0

        static let todayLineWidth: CGFloat = 2.0
        static let defaultLineWidth: CGFloat = 1.0

        static let todayFontSize: CGFloat = 20.0
        static let defaultFontSize: CGFloat = 16.0

        static let todayStrokeColor: Color = .gray
        static let defaultStrokeColor: Color = .lightGray

        static let todayBackgroundColor: Color = Color.lightGray
        static let defaultBackgroundColor: Color = .clear
    }

    private var lineWidth: CGFloat {
        day.isToday ? Constants.todayLineWidth : Constants.defaultLineWidth
    }

    private var strokeColor: Color {
        day.isToday ? Constants.todayStrokeColor : Constants.defaultStrokeColor
    }

    private var fontSize: CGFloat {
        day.isToday ? Constants.todayFontSize : Constants.defaultFontSize
    }

    private var backgroundColor: Color {
        day.isToday ? Constants.todayBackgroundColor.opacity(Constants.opacity) : Constants.defaultBackgroundColor
    }

    let day: Day
    let size: CGFloat

    var body: some View {
        VStack {
            Text(DateHelper.convertToString(day.date, format: .short))
                .font(.system(size: fontSize))
                .multilineTextAlignment(.center)
        }
        .frame(width: size, height: Constants.aspectRatio * size)
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(strokeColor, lineWidth: lineWidth)
                .background(backgroundColor)
                .shadow(radius: Constants.shadowRadius)
        }
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, Constants.padding)
    }
}
