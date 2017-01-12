
import UIKit
import ReactiveSwift
import Result
import Alamofire

public class ModelViewModel {

  private let endpoint = "http://127.0.0.1:8090/yachts/"

  private var lastSearchString = ""
  private var models: [Yacht] = []

  private var providerObserver: Disposable?
  public let viewData: MutableProperty<ModelViewData> = MutableProperty(.empty)

  public func refetch() {
    fetch(searchString: lastSearchString)
  }

  public func fetch(searchString:String) {

    lastSearchString = searchString
    
    Alamofire.request(endpoint).responseJSON { response in
      if let JSON = response.result.value {

        let response = JSON as! NSDictionary
        
        if let data = response.object(forKey:"data") {
          if let jsonResult = data as? Array<Dictionary<String,Any>> {
            for record in jsonResult {
              self.models.append( Yacht.deserialize(dictionary: record))
            }
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
    let allModels: [ModelRowViewData] =  models.map({
      ModelRowViewData(
        title: $0.name,
        imageURL:URL(string: $0.imageURL) ?? URL(string:"http://nrgene.com/wp-content/plugins/lightbox/images/No-image-found.jpg")!,
        rating:9,
        architect:$0.architect
      )
    }).sorted{$0.title < $1.title }

    let newData = ModelViewData(title: "Models \(allModels.count)", list: allModels)

    viewData.modify { value in
      value = newData
    }
  }

}
