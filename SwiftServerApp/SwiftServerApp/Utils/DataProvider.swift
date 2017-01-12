
import Foundation
import ReactiveSwift
import Result

public enum ProviderError: Error {
  case networking(error: Error)
  case noData()
  case unknown()
  case unhandledMeta(meta: [String: Any]?)

  case notify_USER_INTERNET_OFFLINE
  case notify_USER_GENERIC_NETWORK
  case notify_USER_TIMEOUT
  case notify_USER_CONNECTION_LOST
  case notify_USER_DATA_NOT_ALLOWED
  case silent
}

public protocol DataAccessProvider {

  associatedtype DataType: Identifiable

  var data: [String: DataType] { get }

  func getAll() -> [DataType]
  func query( modelID:Identifier ) -> [DataType]

  var events: Signal<(), NoError> { get }
}



