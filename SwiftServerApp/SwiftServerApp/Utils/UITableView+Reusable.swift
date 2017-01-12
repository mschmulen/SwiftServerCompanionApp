
import UIKit

protocol UIReusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension UIReusable {

  static var reuseIdentifier: String {
    let fullClassString = NSStringFromClass( self)
    let compArr = fullClassString.characters.split{$0 == "."}.map(String.init)
    let className = compArr[1]
    return className
  }

  static var nib: UINib? { return nil }
}

extension UITableView {

  func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: UIReusable {
    if let nib = T.nib {
      self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    } else {
      self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: UIReusable {
    return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}

public protocol AnimatedTableViewCellProtocol {
    func startAnimation()
}


