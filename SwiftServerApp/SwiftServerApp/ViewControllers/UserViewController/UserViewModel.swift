
import UIKit
import ReactiveSwift
import Result
import Alamofire

public class UserViewModel {

  private let endpoint = "http://127.0.0.1:8090/users/"

  private var lastSearchString = ""
  private var models: [User] = []

  private var providerObserver: Disposable?
  public let viewData: MutableProperty<UserViewData> = MutableProperty(.empty)

  public func refetch() {
    fetch(searchString: lastSearchString)
  }

  public func fetch(searchString:String) {

    lastSearchString = searchString
    
    Alamofire.request(endpoint).responseJSON { response in
      if let JSON = response.result.value {

        let response = JSON as! NSDictionary
        if let data = response.object(forKey:"data"), let jsonResult = data as? Array<Dictionary<String,Any>> {
          for record in jsonResult {
            self.models.append( User.deserialize(dictionary: record))
          }
        }
        self.vend()
      }
    }
    clearModels()
  }

  public func select( item:Identifier ) {
    print("selected item \(item)")
  }

  private func clearModels() {
    self.models.removeAll()
    self.vend()
  }

  private func vend() {
    let allModels: [UserRowViewData] =  models.map({
      UserRowViewData(
        title: $0.name,
        imageURL:URL(string: $0.imageURL) ?? URL(string:"http://nrgene.com/wp-content/plugins/lightbox/images/No-image-found.jpg")!,
        email:$0.email
      )
    }).sorted{$0.title < $1.title }

    let newData = UserViewData(title: "Users \(allModels.count)", list: allModels)

    viewData.modify { value in
      value = newData
    }
  }

}
