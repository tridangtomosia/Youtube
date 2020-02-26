
import UIKit

class CommentTableViewCell: BaseTableViewCell {
    @IBOutlet weak var namePeopleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var viewCoutLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.boundView(cornerRadius: avatarImageView.bounds.halfHeight,
                                  borderWidth: 0.5,
                                  borderColor: UIColor.black.cgColor,
                                  maskToBound: true)
    }
    
    func setLocal(withComment comment: Comment) {
        namePeopleLabel.text = comment.name
        commentLabel.text = comment.comment
        timeLabel.text = comment.time
        avatarImageView.loadImageUrl(withUrl: comment.avatar)
        viewCoutLabel.text = "Like: " + String(comment.likeCout)
    }
}
