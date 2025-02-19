import Foundation

public protocol Storage {
    associatedtype Model

    var dataSource: [Model] { get }

    func add(_ model: Model)
    func update(_ model: Model)
    func delete(_ model: Model)
}
