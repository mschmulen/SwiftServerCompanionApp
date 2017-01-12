
import UIKit

class UserDetailViewController: UIViewController {

  var back: (() -> Void)?

  let model:UserRowViewData

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var labelName: UILabel! {
    didSet {
      labelName.text = model.title
    }
  }

  @IBOutlet weak var labelArchitect: UILabel! {
    didSet{
      labelArchitect.text = model.email
    }
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    downloadImage(model.imageURL)
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, data:UserRowViewData) {
    self.model = data
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init( data:UserRowViewData)
  {
    self.init(nibName: "UserDetailViewController", bundle: Bundle(for: UserDetailViewController.self), data:data )
  }
}

extension UserDetailViewController {

  func downloadImage(_ url: URL) {
    getDataFromUrl(url) { (data, response, error)  in
      DispatchQueue.main.async { () -> Void in
        guard let data = data , error == nil else {
          return
        }

        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = UIImage(data: data)
      }
    }
  }
}

