
import UIKit
import ReactiveSwift
import Result

open class TopNavViewController: UITabBarController {

  let token:String
  
  // MARK: - VC Lifecyle
  override open func viewDidLoad() {
    super.viewDidLoad()
  }

  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: – init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, token:String ) {
    self.token = token
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init() {

    self.init(nibName: nil, bundle: nil, token:"yack" )
    
    let nvcModels = ModelViewController.factoryNav(searchEnabled: true)
    let nvcUsers = UserViewController.factoryNav()

    let viewControllers = [ nvcUsers, nvcModels]
    self.viewControllers = viewControllers
  }

}

