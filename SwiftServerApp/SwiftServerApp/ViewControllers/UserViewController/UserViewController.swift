
import UIKit
import ReactiveSwift
import Result

public struct UserViewData : ViewDataProtocol {
  var title:String
  let list:[UserRowViewData]
  
  static var empty: UserViewData {
    return UserViewData(title: "~", list: [])
  }
}

public struct UserRowViewData : ViewDataProtocol {

  let title:String
  let imageURL:URL
  let email:String

  static var empty: UserRowViewData {
    return UserRowViewData(
      title:"~",
      imageURL:URL(string: "http://img00.deviantart.net/0fbb/i/2012/362/0/8/sail_boat_png___by_alzstock-d5pgl04.png")!,
      email:"~"
    )
  }
}

class UserViewController: UIViewController , ViewDataObserving {

  var updateSearch: ((String) -> Void)?
  var selectUserWith: ((Identifier) -> Void)?
  var refresh: (()->Void)?

  @IBOutlet weak var tableView: UITableView!
  var refreshControl:UIRefreshControl!
  
  let cellReuseIdentifier: String = "UserTableViewCell"
  let cellNibName: String = "UserTableViewCell"

  let viewData: MutableProperty<UserViewData> = MutableProperty(.empty)
  func viewDataDidChange(from old: UserViewData, to new: UserViewData) {
    self.title = viewData.value.title
    tableView.reloadData()
    self.refreshControl.endRefreshing()
  }

  func pullToRefresh()
  {
    self.refreshControl.beginRefreshing()
    refresh?()
    self.refreshControl.endRefreshing()
  }
  
  // MARK: - init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init()
  {
    self.init(nibName: "UserViewController", bundle: Bundle(for: UserViewController.self))
  }

  deinit {
  }

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    //configure the tableview
    tableView.dataSource = self
    tableView.delegate = self

    tableView.register (
      UINib(nibName: cellNibName, bundle: Bundle(for: UserViewController.self)),
      forCellReuseIdentifier: cellReuseIdentifier
    )

    tableView.rowHeight = UserTableViewCell.rowHeight
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(UserViewController.pullToRefresh), for: UIControlEvents.valueChanged)
    tableView.addSubview(refreshControl)
    tableView.reloadData()

    updateSearch?("")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //refresh?()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    viewData.producer.combinePrevious(.empty).startWithValues { old, new in
      self.viewDataDidChange(from: old, to: new)
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension UserViewController : UITableViewDataSource {

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData.value.list.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UserTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    let record = viewData.value.list[indexPath.item]
    cell.loadItem( record )
    return cell
  }

}

extension UserViewController : UITableViewDelegate {

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = UserDetailViewController(data: viewData.value.list[indexPath.item] )
    if let nav = self.navigationController {
      nav.pushViewController(vc, animated: true)
    }
    else
    {
      self.present(vc, animated: true, completion: nil)
    }
  }
}

extension UserViewController {

  public static func factoryNav(searchEnabled:Bool = true) -> UINavigationController {

    let title = "Users"
    let vm = UserViewModel()
    let vc = UserViewController()
    vc.observe(vm.viewData)
    vc.updateSearch = { searchString in
      vm.fetch(searchString: searchString)
    }
    vc.selectUserWith = { id in
      print( " id\(id)")
    }
    vc.refresh = {
      vm.refetch()
    }

    let nvc = UINavigationController(rootViewController: vc)
    nvc.tabBarItem = UITabBarItem(title: title, image: nil, tag:2)
    //    nvc.tabBarItem.setFAIcon(FAType.faShoppingCart)
    vc.title = title

    return nvc
  }

}
