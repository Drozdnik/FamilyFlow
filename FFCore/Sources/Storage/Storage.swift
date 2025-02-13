import Foundation

public protocol Storage {
    associatedtype Model

    var dataSource: [Model] { get }

    func add(_ model: Model)
    func update(_ model: Model)
    func delete(_ model: Model)
}

public struct MockStorageImpl: Storage {
    public var dataSource: [Void]

    public func add(_ model: Void) {}
    public func update(_ model: Void) {}
    public func delete(_ model: Void) {}
}
