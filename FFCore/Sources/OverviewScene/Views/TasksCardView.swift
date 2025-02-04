import SwiftUI

struct TasksCardView: View {
    let task: TaskModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
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
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
