import Foundation

protocol TasksBaseVM: ObservableObject {
    associatedtype Item: Identifiable

    var title: String { get }
    var items: [Item] { get }

    func updateProgress(_: TaskProgress)
    func createItem()
}

extension TasksBaseVM {
    func updateProgress(_: TaskProgress) {}
}
