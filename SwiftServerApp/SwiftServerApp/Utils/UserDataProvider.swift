
import Foundation
import ReactiveSwift
import Result

public class UserDataProvider: DataAccessProvider {

  public let events: Signal<(), NoError>
  private let eventsObserver: Signal<(), NoError>.Observer

  private(set) public var data: [String: User] = [:] { didSet { eventsObserver.send(value: ()) }}

  init() {
    (self.events, self.eventsObserver) = Signal.pipe()
  }
  
  public func query(modelID:  Identifier) -> [User] {
    let accumulator = data.filter { _, models in
      return models.id == modelID
    }
    return accumulator.flatMap { $0.value }
  }

  public func getAll() -> [User] {
    return data.flatMap { $0.value  }
  }

  func add(models: [User]) {
    for model in models {
      data[model.id] = model
    }
  }

}
