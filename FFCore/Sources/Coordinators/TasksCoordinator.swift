import SwiftUI
import UIKit

final class TasksCoordinatorImpl<TasksStorage: Storage>: Coordinator where TasksStorage.Model == TaskModel {
    private(set) var tasksStorage: TasksStorage
    private(set) var rootViewController: UIViewController?
    private(set) var childCoordinators: [any Coordinator] = []

    init(tasksStorage: TasksStorage) {
        self.tasksStorage = tasksStorage
    }

    func start() {
        let viewModel = TasksViewModel<TasksStorage>(tasksStorage: tasksStorage)
        let view = TasksView(viewModel: viewModel)
        rootViewController = UIHostingController(rootView: view)
    }
}
