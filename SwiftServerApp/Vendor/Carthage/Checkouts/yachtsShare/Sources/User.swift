
import Foundation

public struct User: Identifiable {
  public let id:Identifier
  public let name:String
  public let email:String
  public let imageURL:String

  static public func deserialize(dictionary:Dictionary<String, Any>) -> User {
    let model = User(
      id: dictionary["id"] as! String,
      name: dictionary["name"] as! String,
      email: dictionary["email"] as! String,
      imageURL: dictionary["imageURL"] as! String
    )
    return model
  }

  public func serialize() -> [String: Any] {
    var model = [String: Any]()
    model["id"] = self.id
    model["name"] = self.name
    model["email"] = self.email
    model["imageURL"] = self.imageURL
    return model
  }

}

extension User: Equatable {
  static public func ==(lhs: User, rhs:User) -> Bool {
    return lhs.id == rhs.id
  }
}
