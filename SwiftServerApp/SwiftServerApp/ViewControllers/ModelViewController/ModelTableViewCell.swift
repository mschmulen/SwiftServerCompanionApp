
import UIKit

class ModelTableViewCell: UITableViewCell, UIReusable {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  static let rowHeight:CGFloat = CGFloat(71.0)

  func loadItem(_ model: ModelRowViewData ) {
    titleLabel.text = model.title
    descriptionLabel.text = model.architect
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    titleLabel.text = ""
    descriptionLabel.text = ""
  }

}



