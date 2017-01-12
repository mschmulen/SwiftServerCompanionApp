
public struct Yacht: Identifiable {
  
  public let id:Identifier
  public let name:String
  public let architect:String
  public let url:String
  public let imageURL:String
  public let likes:Int

  static public func deserialize(dictionary:Dictionary<String, Any>) ->Yacht {
    let model = Yacht(
      id: dictionary["id"] as! String,
      name: dictionary["name"] as! String,
      architect: dictionary["architect"] as! String,
      url: dictionary["url"] as! String,
      imageURL: dictionary["imageURL"] as! String,
      likes: dictionary["likes"] as! Int
    )
    return model
  }
  
  public func serialize() -> [String: Any] {
    var model = [String: Any]()
    model["id"] = self.id
    model["name"] = self.name
    model["url"] = self.url
    model["architect"] = self.architect
    model["imageURL"] = self.imageURL
    model["likes"] = self.likes
    return model
  }

}

extension Yacht: Equatable {
  static public func ==(lhs: Yacht, rhs:Yacht) -> Bool {
    return lhs.id == rhs.id
  }
}

