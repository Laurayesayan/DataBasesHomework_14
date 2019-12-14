import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tasksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
