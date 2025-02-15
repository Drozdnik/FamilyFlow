import SwiftUI

struct TasksCardView: View {
    let task: TaskItem

    enum Constants {
        static let spacing = 5.0
        static let cornerRadius = 10.0
        static let shadowRadius = 3.0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(task.title)
                .font(.headline)
            Text("Срок: \(task.deadline)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Приоритет: \(task.priority)")
                .font(.subheadline)
            Text("Ответственный: \(task.assignee)")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: Constants.shadowRadius)
    }
}
