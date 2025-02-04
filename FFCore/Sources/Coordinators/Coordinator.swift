import UIKit

@MainActor
public protocol Coordinator: AnyObject {
    func start()
    var rootViewController: UIViewController { get }
}

protocol TasksCoordinator: Coordinator {
    var tasksStorage: TaskStorage { get }
}
