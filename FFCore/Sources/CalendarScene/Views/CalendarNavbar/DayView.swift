import SwiftUI

struct DayView: View {
    private enum Constants {
        static let cornerRadius: CGFloat = 10.0
        static let aspectRatio: CGFloat = 1.2
        static let shadowRadius: CGFloat = 2.0

        static let animationDuration: TimeInterval = 0.25

        static let padding: CGFloat = 4.0
    }

    struct LayoutParameters {
        let size: CGFloat
        let lineWidth: CGFloat
        let strokeColor: Color
        let fontSize: CGFloat
        let backgroundColor: Color
    }

    @Binding var selectedDay: Day
    let day: Day
    let layoutParameters: LayoutParameters

    var body: some View {
        VStack {
            Text(DateHelper.convertToString(day.date, format: .short))
                .font(.system(size: layoutParameters.fontSize))
                .multilineTextAlignment(.center)
        }
        .frame(width: layoutParameters.size, height: Constants.aspectRatio * layoutParameters.size)
        .animation(.easeInOut(duration: Constants.animationDuration), value: selectedDay)
        .background(backgroundRectangle)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, Constants.padding)
        .onTapGesture {
            withAnimation {
                if selectedDay != day {
                    selectedDay = day
                }
            }
        }
    }

    private var backgroundRectangle: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(layoutParameters.strokeColor, lineWidth: layoutParameters.lineWidth)
            .background(layoutParameters.backgroundColor)
            .shadow(radius: Constants.shadowRadius)
    }
}
