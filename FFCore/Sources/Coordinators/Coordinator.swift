import UIKit

public protocol Coordinator: AnyObject {
    @MainActor func start()

    var rootViewController: UIViewController? { get }
    var childCoordinators: [any Coordinator] { get }
}
