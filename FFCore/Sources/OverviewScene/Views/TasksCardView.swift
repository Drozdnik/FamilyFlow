import SwiftUI
private enum Constants {
    static let spacing = 5.0
    static let cornerRadius = 10.0
    static let shadowRadius = 3.0
}

struct TasksCardView<Item>: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            contentView
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: Constants.shadowRadius)
    }

    @ViewBuilder
    private var contentView: some View {
        switch item {
        case let task as TaskItem:
            taskView(for: task)
        case let room as Room:
            roomView(for: room)
        default:
            EmptyView()
        }
    }

    private func taskView(for task: TaskItem) -> some View {
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

    private func roomView(for item: Room) -> some View {
        Text("\(item.title)")
            .font(.headline)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
