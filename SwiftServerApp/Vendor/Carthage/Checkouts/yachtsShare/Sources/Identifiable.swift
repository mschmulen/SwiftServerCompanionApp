
public typealias Identifier = String

public protocol Identifiable: Hashable {
  var id: Identifier { get }
}

extension Identifiable {
  public var hashValue: Int {
    return id.hashValue
  }
}
