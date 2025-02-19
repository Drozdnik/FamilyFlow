import SwiftUI

struct TaskCardView: CardViewItemProtocol {
    private enum Constants {
        static let spacing = 5.0
    }

    let task: TaskItem

    var contentView: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(task.title)
                .font(.headline)
                .foregroundColor(.primary)
            Text("Срок: \(task.deadline)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Приоритет: \(task.priority)")
                .font(.subheadline)
                .foregroundColor(.primary)
            Text("Ответственный: \(task.assignee)")
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}
