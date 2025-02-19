import SwiftUI

struct TaskHeaderView: View {
    private enum Constants: Double {
        case headerViewSpacing = 5.0
        case padding = 10.0
    }

    let viewModel: TasksViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.headerViewSpacing.rawValue) {
            Text("ID: \(viewModel.id)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Прогресс: \(viewModel.progressDescription)")
                .font(.headline)
        }
        .padding(.leading, Constants.padding.rawValue)
    }
}
