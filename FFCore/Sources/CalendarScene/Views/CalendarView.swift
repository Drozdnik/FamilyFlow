import SwiftUI

struct CalendarView: View {
    @ObservedObject private(set) var viewModel: CalendarViewModel

    init(calendarViewModel: CalendarViewModel) {
        self.viewModel = calendarViewModel
    }

    var body: some View {
        VStack {
            CalendarNavbar(selectedWeek: $viewModel.selectedWeek, selectedDay: $viewModel.selectedDay)
            Spacer()
            Text("CalendarView in development")
            Spacer()
        }
    }
}

 #Preview {
    @Environment(\.diContainer) var diContainer
    CalendarView(
        calendarViewModel: CalendarViewModel(tasksStorage: diContainer.tasksStorage)
    )
 }
