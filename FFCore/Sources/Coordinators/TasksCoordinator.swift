import SwiftUI
import UIKit

final class TasksCoordinatorImpl: TasksCoordinator {

    let tasksStorage: TaskStorage
    private(set) var rootViewController: UIViewController

    init(taskStorage: TaskStorage) {
        self.tasksStorage = taskStorage
        rootViewController = UIViewController()
    }

    func start() {
        let viewModel = TasksViewModel(taskStorage: tasksStorage)
        let view = TasksView(viewModel: viewModel)
        rootViewController = UIHostingController(rootView: view)
    }
}
