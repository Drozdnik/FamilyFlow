import Foundation

@MainActor
public protocol Coordinator: AnyObject {
    func start()
}
